Content-Type: multipart/mixed; boundary="===============4792752703242362528=="
MIME-Version: 1.0
From: Joseph Benden <joe at benden.us>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/7] storage: implement network profile encryption
Date: Fri, 04 Feb 2022 17:52:15 -0700
Message-ID: <3f97672e-a48f-6b66-e138-5e3d5af19b6f@benden.us>
In-Reply-To: cfbb2d3a56d271ee240d7e09bb221033a79ec045.camel@gmail.com

--===============4792752703242362528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2/4/22 4:23 PM, James Prestwood wrote:
> Hi Joseph,
>
> On Fri, 2022-02-04 at 15:55 -0700, Joseph Benden wrote:
>> Hi!
>>
>> It is my understanding that all secret data is to be kept as securely
>> as
>> possible. I'm not really seeing this carried throughout the source
>> code.
>> Maybe this specific code does not need that level of security?
> Currently any profile (e.g. /var/lib/iwd/foo.psk) containing secret
> data is unencypted, plaintext. We rely on the file system permissions
> to 'secure' this data (which this patch series is 'fixing' for anyone
> who wants these encrypted).

Icky... really shouldn't do it this way; secure all data at rest - even =

against root account, if at all possible.

>
>> If I'm right, then:
>>
>> The secret data should be kept in a mmap(), and mlock(), structure.
>> The
>> prevents secret data from hitting swap memory. After every use of the
>> secret data; it must be explicit_bzero() and then free(). This is so
>> critical and tedious that it should be a macro or something from
>> libell.
>> And those are just initial thoughts for the basic safety of the
>> secret data.
> So this is how the systemd feature works: The IWD service is given a
> path to a file. This file is decrypted by systemd and contains the
> 'secret'. IWD then reads this secret in, does some hashing, and stores
> the hashed secret in RAM. Once IWD is done it never accesses the file
> again.
>
> So I don't think its even possible for IWD to do this mmap/mlock dance
> you're describing. It really doesn't own this secret file, nor does it
> keep the file contents around long. It just derives a fixed length key
> and never uses the file again.

So this is a can of worms... As soon as the secret data hits disk, it is =

out-of-ones own control; considered revealed and/or exploited. I sure do =

hope systemd does the right things here... (facepalm)

>
> As far as explicit_bzero'ing the hashed secret after every use, then
> reading it back in, and hashing it again when needed... this seems a
> bit crazy :)

Maybe crazy, most certainly needed. If not now, probably needed in the =

near future (after some horrible event).

So let's talk about data flows for a moment.

IWD service starts and initializes a secret data vault. This is a region =

of memory which is mmap()-ed, mlock() protected, and which happens to =

point to the start of a fixed struct - that is for IWD service's secret =

data store. [I envision libell having support for application secret vaults]

The external secret data enters from a file; it is read to the secret's =

vault, and is securely processed to have the derived secret data (these =

two values are in the IWD service's secret data store).

Providing compatible with systemd's process; the secret data file is =

shredded (see DoD -style procedures for examples), and unlink()-ed from =

the file-system. Also (shred) explicit_bzero()-ing the filenames used =

and any and all memory used that is not inside of the IWD service's =

secret data store. [I envision libell having a file_shred() function, =

using the 6/8-pass (iirc) or so methods.]

Now, when the secret derived data is needed for incoming/outgoing =

frames; it is always used directly from the service's secret data store. =

Try your darn-ist to not copy it out of its place in the vault, and if =

it is: it must be securely used and tracked for correctness.

Finally at program shutdown, the IWD service's secret data store is =

shredded (this is explicit_bzero()-ed), then munlock(), and munmap()-ed.

Best regards,
-Joe


--===============4792752703242362528==--

