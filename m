Content-Type: multipart/mixed; boundary="===============3636817571131661119=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/7] storage: implement network profile encryption
Date: Mon, 07 Feb 2022 14:44:03 -0600
Message-ID: <fd7febad-341e-a1f8-111f-741a13323d30@gmail.com>
In-Reply-To: 3f97672e-a48f-6b66-e138-5e3d5af19b6f@benden.us

--===============3636817571131661119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joseph,

On 2/4/22 18:52, Joseph Benden wrote:
> On 2/4/22 4:23 PM, James Prestwood wrote:
>> Hi Joseph,
>>
>> On Fri, 2022-02-04 at 15:55 -0700, Joseph Benden wrote:
>>> Hi!
>>>
>>> It is my understanding that all secret data is to be kept as securely
>>> as
>>> possible. I'm not really seeing this carried throughout the source
>>> code.
>>> Maybe this specific code does not need that level of security?
>> Currently any profile (e.g. /var/lib/iwd/foo.psk) containing secret
>> data is unencypted, plaintext. We rely on the file system permissions
>> to 'secure' this data (which this patch series is 'fixing' for anyone
>> who wants these encrypted).
> =

> Icky... really shouldn't do it this way; secure all data at rest - even a=
gainst =

> root account, if at all possible.
> =


There are lots of interesting ideas in this thread... I'm not aware of any =

networking daemons actually doing any of the stuff you describe here.  iwd =
could =

be the first of course.

> =

> So this is a can of worms... As soon as the secret data hits disk, it is =

> out-of-ones own control; considered revealed and/or exploited. I sure do =
hope =

> systemd does the right things here... (facepalm)

Well, you may want to check what systemd is doing first.  I suspect the dat=
a =

never actually hits disk, but goes into tmpfs.

> =

>>
>> As far as explicit_bzero'ing the hashed secret after every use, then
>> reading it back in, and hashing it again when needed... this seems a
>> bit crazy :)
> =

> Maybe crazy, most certainly needed. If not now, probably needed in the ne=
ar =

> future (after some horrible event).
> =

> So let's talk about data flows for a moment.
> =

> IWD service starts and initializes a secret data vault. This is a region =
of =

> memory which is mmap()-ed, mlock() protected, and which happens to point =
to the =

> start of a fixed struct - that is for IWD service's secret data store. [I =

> envision libell having support for application secret vaults]
> =

> The external secret data enters from a file; it is read to the secret's v=
ault, =

> and is securely processed to have the derived secret data (these two valu=
es are =

> in the IWD service's secret data store).
> =


Sounds useful.  Any chance you would be willing to contribute?

> Providing compatible with systemd's process; the secret data file is shre=
dded =

> (see DoD -style procedures for examples), and unlink()-ed from the file-s=
ystem. =

> Also (shred) explicit_bzero()-ing the filenames used and any and all memo=
ry used =

> that is not inside of the IWD service's secret data store. [I envision li=
bell =

> having a file_shred() function, using the 6/8-pass (iirc) or so methods.]

See above.  I doubt this is needed.  But even if systemd somehow writes the =

secret to disk, it is not up to iwd to destroy it.

> =

> Now, when the secret derived data is needed for incoming/outgoing frames;=
 it is =

> always used directly from the service's secret data store. Try your darn-=
ist to =

> not copy it out of its place in the vault, and if it is: it must be secur=
ely =

> used and tracked for correctness.

Again, this sounds useful and could be fairly easily accomplished for many =
of =

the common scenarios.  For example, most of the derived keys for the curren=
t =

connection are already stored in a single object and such memory could be l=
ocked =

if desired.  But this is a separate topic from what this patch set is tryin=
g to =

accomplish.  Feel free to start a new thread on this topic specifically.

> =

> Finally at program shutdown, the IWD service's secret data store is shred=
ded =

> (this is explicit_bzero()-ed), then munlock(), and munmap()-ed.
> =


See above.  systemd owns the secret, so there's nothing for iwd to do here.

Regards,
-Denis
--===============3636817571131661119==--

