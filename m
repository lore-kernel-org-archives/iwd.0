Content-Type: multipart/mixed; boundary="===============3864317550003636714=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Cannot connect to SAE protected AP with iwd 1.16 and beyond
Date: Tue, 31 Aug 2021 08:24:43 -0500
Message-ID: <3d7b55d0-c0ad-f347-4764-bea6b9afae84@gmail.com>
In-Reply-To: <20210831055406.2717.71292@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3864317550003636714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jesus,

On 8/31/21 12:54 AM, Jesus Gonzalez wrote:
> Hello Denis,
> =

> this was with no NetworkManager running, and before and after a "known-ne=
tworks forget" (so also entering the PSK again on "station wlan0 connect"),=
 just in case it was what you just pointed out, which also was my first rea=
ction to that message.

Hard to say anything definitively without seeing the logs, but I'm not sure =

anything is really wrong?

You're trying to connect to your SAE AP with iwd 1.16, right? So that is =

expected to fail: 'station wlan0 connect <foo>' will fail, and autoconnect =
will =

take over.  It will find nothing to connect to, as expected.

You may want to just post the log.

Regards,
-Denis
--===============3864317550003636714==--

