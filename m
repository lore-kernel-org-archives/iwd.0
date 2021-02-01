Content-Type: multipart/mixed; boundary="===============6785318342795052661=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] client: add support for AP StartProfile
Date: Mon, 01 Feb 2021 15:38:44 -0600
Message-ID: <bf89d8e9-2501-8602-ccfe-e37fbcd23689@gmail.com>
In-Reply-To: <20210201171717.7215-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6785318342795052661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/1/21 11:17 AM, James Prestwood wrote:
> StartProfile was added to the AP interface but the required
> command was never added to iwctl. This command requires a
> profile exists in <configuration dir>/ap/. The syntax is as
> follows:
> =

> ap <wlanX> start-profile <profile_name>
> ---
>   client/ap.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============6785318342795052661==--

