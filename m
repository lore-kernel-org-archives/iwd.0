Content-Type: multipart/mixed; boundary="===============1366989398016554800=="
MIME-Version: 1.0
From: 54d22547-afc0-4701-b1fc-5a2a2e411646 at simplelogin.co
To: iwd at lists.01.org
Subject: iwd 1.21 stuck on connecting state
Date: Thu, 13 Jan 2022 11:27:14 +0000
Message-ID: <20220113112714.2807.22007@ml01.vlan13.01.org>

--===============1366989398016554800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I've recently started noticing on my laptop that iwd gets stuck on 'connect=
ing' state when I boot a **second time** right after poweroff. The fix is q=
uite easy. Just disconnect and connect again from iwctl.

I recall having a similar issue not long ago. Maybe a regression was introd=
uced. For the record, router and connection settings are the same as before.

Arch Linux with kernel 5.16-zen1.

Thanks!
--===============1366989398016554800==--

