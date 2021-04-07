Content-Type: multipart/mixed; boundary="===============1108327016439268025=="
MIME-Version: 1.0
From: Arseny Maslennikov <ar@cs.msu.ru>
Subject: Re: [issue] Can't connect to a WPA2-Enterprise network: 4-way
 handshake timeout
Date: Wed, 07 Apr 2021 14:07:26 +0300
Message-ID: <YG2SbpHPGIGKsIzv@cello>
In-Reply-To: <79680adc-7d8a-dfd1-744e-97cfe8c13f85@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1108327016439268025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 11:30:03AM -0500, Denis Kenzior wrote:
> Hi Arseny,
> =

> On 3/28/21 6:05 AM, Arseny Maslennikov wrote:
> > Hi everyone!
> > =

> > I'm running iwd 1.12 on Debian sid, package version 1.12-1.
> > I'm trying to connect to a WPA2-Enterprise network with the following
> > network config file produced by NetworkManager, to no avail:
> > =

> > [Security]
> > EAP-Method=3DPEAP
> > EAP-Identity=3D
> =

> So an empty Identity frequently causes some EAP servers to get confused. =
 In
> theory the outer identity is completely optional, but quite often it is
> required in practice (probably due to a mis-configured RADIUS server).  T=
ry
> setting it to anonymous(a)your.org or using your Phase2 identity.

I have tried EAP-Identity=3Danonymous(a)example.org (in case just a
non-empty field is required) to no success.
Then I have tried EAP-Identity=3D<the Phase2 identity>, and it suddenly wor=
ked!

The user is not required to know this trick beforehand, though: other
solutions work automagically, and NM + wpa_supplicant in particular
don't require the user to fill in the outer identity.
I'm not sure if this is an issue in IWD (i. e., as a workaround, it should =
try phase2
identity equal to the outer identity if the connection fails and
EAP-Identity is empty), or in the NM backend (i. e. it should try this
workaround when provisioning settings to IWD), though, or if this is an
AP/RADIUS configuration issue and does not have to be fixed in Wi-Fi
client software at all...

Anyway, thanks a lot for the help!

--===============1108327016439268025==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUVCQ2dBZEZpRUU1NkpEM1VLVExF
dS9kZHJtOWRRanlBWUwwMUFGQW1CdGttY0FDZ2tROWRRanlBWUwKMDFBSlhSQUF4blNLaXo2UERI
MXJUT1h6dm41Rlc1Q2RUbGo4SWMrSDFsU1l1SkM3S1FIaDVDWDRwb1FiTWFxaQordHFLOW12Mm1L
dTQ3dnpJWmlXTEluTm41RHhPdDQ0L2s0a1VlVG81bXBXUFZEbDQzNTRTSVcvTHlRdHVBQ3dlCjhH
TEI0ZFFBZklneWhWdVI5Nzk3cjl4ZzJrd3c5NUx6UWEvTDltZlNNdThZTWw5Z3h2MU9RdE5qZHhw
Q0hpN3IKR1ZwR1R5d3gvcnNVWjlOMW5KVGRKYXJuWno4WjVCZXhKdURVdWNMWkRhZzEzS21Za0dy
RXhpVzEwY2syNFlyUAozOVY4OFhEa08xTzQrVGdoWndseTlqcStkNnE2V29Ld2ExeW5MV3NBOU1Q
RStzYit3akoyZXpnRHNVTmIwL3lLCnhtYTU1UElsNUw4d21sOVhNOUpVdzgrYkVtS0xMNUc0OThl
aERpS2tWTkxlZE9jNUJpelBuMC91Z0FuSnIwTDEKQnhDT3RYUVpDbXdUaWJPOXNrS1BScEZma0Fr
aWVaSlpkbGNOdTMyYkk0cGwwK2wvamtXZEZVNzNHcnRBSzFURwp5czVtU3RQSzQrVStWajR5YUUr
Q3ZwQWc5QVBLT3ZSRDF3SUV1YUN6YTUxU3picS9tQmhOekxKb2ppRFREYVI1Cm9iYmxzb29wZGZF
RXp6bEFIV0xsTm44bEFUQVczdFdIeUhBQ290VVFuZWZIYUF5VUNYLy9XWnEvc3BhMFVMVTgKOHVa
NzRtKzNMU3pkaHJiRmxJZnlwbnZPS3JuVE9hTTM0bGZxanR0emwyL3NoekxrRnpkcjg0RUlBbjN1
dHFidQovZWxBQXFDL2JVSGZOeGVQNkM2L1FEUzF1RnNWcEJBbnlZaHBiazFaQm4yMVExNWpGWW89
Cj1PTThzCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============1108327016439268025==--

