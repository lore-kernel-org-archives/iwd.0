Content-Type: multipart/mixed; boundary="===============3713834363750610160=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] Send hostname as part of DHCP request.
Date: Fri, 18 Jun 2021 13:11:27 -0500
Message-ID: <040d08de-a498-acad-cd8e-6cc1ec8b538f@gmail.com>
In-Reply-To: <20210618174046.207396-1-mjohnson459@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3713834363750610160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 6/18/21 12:40 PM, Michael Johnson wrote:
> This is based on a previous patch by Roberto Santalla Fern=C3=A1ndez.
> =

> A new config is introduced into the network config file under IPv4
> called SendHostname. If this is set to true then we add the hostname
> into all DHCP requests. The default is false.
> ---
>   src/iwd.network.rst |  6 ++++++
>   src/netconfig.c     | 16 ++++++++++++++++
>   2 files changed, 22 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============3713834363750610160==--

