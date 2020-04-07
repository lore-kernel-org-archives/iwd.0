Content-Type: multipart/mixed; boundary="===============5133173932588625031=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] client: fix ad-hoc start_open DBus method name
Date: Tue, 07 Apr 2020 22:25:38 +0000
Message-ID: <910e1bd8-46a1-87d7-c3bc-2ee0523f7c4d@gmail.com>
In-Reply-To: <20200407213347.32130-1-Diego.SantaCruz@spinetix.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5133173932588625031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Diego,

On 4/7/20 4:33 PM, Diego Santa Cruz wrote:
> Doing 'ad-hoc <wlan> start_open <"network name">' returned a
> "No matching method found" error because start_open called
> net.connman.iwd.AdHoc.Start instead of net.connman.iwd.AdHoc.StartOpen.
> ---
>   client/ad-hoc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Nice catches!  All applied, thanks.

Regards,
-Denis

--===============5133173932588625031==--

