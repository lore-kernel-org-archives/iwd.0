Content-Type: multipart/mixed; boundary="===============3872557865258022248=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] agent: enforce a maximum passphrase length
Date: Fri, 06 Mar 2020 12:43:05 -0600
Message-ID: <6849889b-89b2-90fb-09f0-0914083d546b@gmail.com>
In-Reply-To: <1879405e9590b4bb759bc52c5a0a383c72e80ecf.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3872557865258022248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>> This callback is used for three things from what I remember:
>> 	1. The passphrase for decrypting private keys
>> 	2. The passphrase for PSK networks.
>> 	3. The password for EAP methods.
>>
>> This checking should only apply to 3, no?
> =

> Well, we should probably have a maximum on all three... The private key
> passphrase is sent to the kernel, so we probably don't want that to be
> huge seems like we could put the same limitation on both 1 and 3. In
> addition for PSK passphrases we should probably enforce 8-63 byte
> lengths if we don't already somewhere else.
> =


I'd be fine with that, but then using a #define with the name PASSWORD =

starts looking a bit funny.

Do note that the 8..63 limit for 2) is already enforced by =

crypto_psk_from_passphrase.

Regards,
-Denis
--===============3872557865258022248==--

