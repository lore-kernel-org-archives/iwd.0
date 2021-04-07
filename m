Content-Type: multipart/mixed; boundary="===============8742818710067322901=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [issue] Can't connect to a WPA2-Enterprise network: 4-way
 handshake timeout
Date: Wed, 07 Apr 2021 13:05:28 -0500
Message-ID: <f15905eb-6ba4-c97f-b05f-26d8cba574cf@gmail.com>
In-Reply-To: <YG2SbpHPGIGKsIzv@cello>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8742818710067322901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arseny,

On 4/7/21 6:07 AM, Arseny Maslennikov wrote:
> On Mon, Mar 29, 2021 at 11:30:03AM -0500, Denis Kenzior wrote:
>> Hi Arseny,
>>
>> On 3/28/21 6:05 AM, Arseny Maslennikov wrote:
>>> Hi everyone!
>>>
>>> I'm running iwd 1.12 on Debian sid, package version 1.12-1.
>>> I'm trying to connect to a WPA2-Enterprise network with the following
>>> network config file produced by NetworkManager, to no avail:
>>>
>>> [Security]
>>> EAP-Method=3DPEAP
>>> EAP-Identity=3D
>>
>> So an empty Identity frequently causes some EAP servers to get confused.=
  In
>> theory the outer identity is completely optional, but quite often it is
>> required in practice (probably due to a mis-configured RADIUS server).  =
Try
>> setting it to anonymous(a)your.org or using your Phase2 identity.
> =

> I have tried EAP-Identity=3Danonymous(a)example.org (in case just a
> non-empty field is required) to no success.
> Then I have tried EAP-Identity=3D<the Phase2 identity>, and it suddenly w=
orked!
> =


Figured.  Sometimes even giving a fake address with your domain works for t=
he =

outer identity.

> The user is not required to know this trick beforehand, though: other
> solutions work automagically, and NM + wpa_supplicant in particular
> don't require the user to fill in the outer identity.

Yes, I know.  We have had some conversations around this internally, but wh=
at it =

comes down to is the issue of privacy.  The outer identity is sent in the c=
lear, =

so having iwd assume that outer identity =3D=3D inner identity would compro=
mise =

privacy.  The extent of the compromise depends on who you ask of course.  F=
or =

now we err on the side of caution and assume that if the 802.1X configurati=
on =

requires the outer identity to be exposed, then this is something that shou=
ld be =

explicitly enabled by the configuration file.

Ideally, the configuration file should be provided by the organization, but =

frequently the end-user is stuck figuring this out.

> I'm not sure if this is an issue in IWD (i. e., as a workaround, it shoul=
d try phase2
> identity equal to the outer identity if the connection fails and
> EAP-Identity is empty), or in the NM backend (i. e. it should try this
> workaround when provisioning settings to IWD), though, or if this is an
> AP/RADIUS configuration issue and does not have to be fixed in Wi-Fi
> client software at all...

The real issue is on the backend.  Properly configured, the outer identity =

should not even be required and should be omitted.  And if the backend cann=
ot be =

fixed (for whatever reason), then the 802.1X settings should call this out =

explicitly.  If this network is eduroam,  [1] may be of interest.

Also note that we do ship a tool to convert Apple WiFi configuration files =
to =

iwd's native format.  So if your organization provides these, this may be =

another avenue to pursue.

> =

> Anyway, thanks a lot for the help!
> =


No problem.  Glad I could help.

Regards,
-Denis

[1] https://github.com/GEANT/CAT/issues/201
--===============8742818710067322901==--

