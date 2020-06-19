Content-Type: multipart/mixed; boundary="===============2178013836244072997=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: IWD on arch64 startup errors
Date: Fri, 19 Jun 2020 14:24:28 -0500
Message-ID: <b1f3618a-e5da-70db-b45d-feea4b42b304@gmail.com>
In-Reply-To: <CAG17S_NX8Navv+Mi_ocoJ_UAVftgjYWfYxPHdEBpJb6te3cvCg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2178013836244072997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On 6/19/20 12:45 AM, KeithG wrote:
> I have been running iwd on armv6 and v7 for a while without issue. I fina=
lly got =

> an image or Arch aarch64 on my RPI running (kernel 5.4.44) and cannot sta=
rt the =

> already compiled for aarch64 version of iwd on this kernel. The journal s=
hows this:
> Jun 18 23:34:02 rune64 systemd[1]: Starting Wireless service...
> Jun 18 23:34:03 rune64 iwd[4088]: No HMAC(SHA1) support found
> Jun 18 23:34:03 rune64 iwd[4088]: No HMAC(MD5) support found
> Jun 18 23:34:03 rune64 iwd[4088]: No CMAC(AES) support found
> Jun 18 23:34:03 rune64 iwd[4088]: No HMAC(SHA256) support not found
> Jun 18 23:34:03 rune64 iwd[4088]: No HMAC(SHA512) support found, certain =
TLS =

> connections might fail
> Jun 18 23:34:03 rune64 iwd[4088]: No Diffie-Hellman support found, WPS wi=
ll not =

> be available
> Jun 18 23:34:03 rune64 iwd[4088]: The following options are missing in th=
e kernel:
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_USER_API_HASH
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_KEY_=
DH_OPERATIONS
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_MD5
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_SHA256
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_AES
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_CMAC
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_USER_API_HASH
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_USER_API_HASH
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_USER_API_HASH

Hmm, what's going on here, sounds like a small bug in the option print code=
. =

I'll fix that.

> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_HMAC
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_HMAC
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_HMAC
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_SHA512
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_SHA1
> Jun 18 23:34:03 rune64 iwd[4088]: The following optimized implementations=
 might =

> be available:
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_SHA1_SSSE3
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_AES_NI_INTEL
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_SHA512_SSSE3
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_AES_X86_64
> Jun 18 23:34:03 rune64 iwd[4088]: =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_CRYP=
TO_SHA256_SSSE3
> Jun 18 23:34:03 rune64 systemd[1]: iwd.service: Main process exited, =

> code=3Dexited, status=3D1/FAILURE
> Jun 18 23:34:03 rune64 systemd[1]: iwd.service: Failed with result 'exit-=
code'.
> Jun 18 23:34:03 rune64 systemd[1]: Failed to start Wireless service.
> =

> I recently built this kernel on a system that was running 5.7.x and iwd 1=
.7.1 =

> was also built on this kernel. When I run iwd on 5.7.x, it runs and funct=
ions. I =

> checked the config and most of these appear as modules but are not built =
in. =

> Must they be built in?

So this is not really an iwd question but a kernel question.  But, the answ=
er is =

no, they do not need to be built-in.

Some subsystems, like the keys subsystem, do not support module autoloading=
.  So =

if you build pkcs8 or pkcs7 parsers as modules, then you'd need to have the=
m =

loaded manually.  iwd does ship a pkcs8.conf file to handle this for exampl=
e. =

However, I believe all of the options checked at startup can be compiled as =

builtin or modules (or a mix) and they're properly handled by the autoloade=
r.

Here's how my kernel is built (not really exhaustive list of options, but y=
ou =

get the idea):

CONFIG_CRYPTO_SHA1=3Dy
CONFIG_CRYPTO_SHA1_SSSE3=3Dy
CONFIG_CRYPTO_SHA256_SSSE3=3Dm
CONFIG_CRYPTO_SHA512_SSSE3=3Dm
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_AES=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_DES3_EDE_X86_64=3Dm

Regards,
-Denis
--===============2178013836244072997==--

