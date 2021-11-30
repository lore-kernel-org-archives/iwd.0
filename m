Content-Type: multipart/mixed; boundary="===============3279835711674760839=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Tue, 30 Nov 2021 16:42:28 -0600
Message-ID: <31be7914-5c78-f1c9-1225-a271204ba153@gmail.com>
In-Reply-To: CAA=hcWTdHD1ez3vVCpdn4ZQB3njpnQ7DG_sO8cB3oD3E8sYDEg@mail.gmail.com

--===============3279835711674760839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jupiter,

> But there is no IP address, I guess iwd manages DHCP, how can I debug iwd=
 DHCP?
> =


iwd can be configured to do so.  You will need to add the appropriate =

configuration entry in /etc/iwd/main.conf.  Refer to 'man 5 iwd.config' or =
the =

rst here: =

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/iwd.config=
.rst#n57

Note that for iwd + connman, connman would be the one performing DHCP and i=
wd =

should use EnableNetworkConfiguration=3Dfalse.  Daniel can correct me if I'=
m wrong.

For DHCP debugging, refer to 'man iwd.debug'.  You will need to set the =

appropriate environment variable (IWD_DHCP_DEBUG or so).  The iwd wiki [1] =
has =

examples.

Regards,
-Denis

[1] https://iwd.wiki.kernel.org/debugging
--===============3279835711674760839==--

