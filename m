Content-Type: multipart/mixed; boundary="===============3397222177380295726=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add capability for port in restricted range.
Date: Tue, 29 Jun 2021 11:44:11 -0500
Message-ID: <c575e5ab-499d-e8fe-14a8-b02e00203365@gmail.com>
In-Reply-To: <20210629160700.133768-1-mjohnson459@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3397222177380295726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 6/29/21 11:07 AM, Michael Johnson wrote:
> This fixes an issue where the udp port was not being opened due to a
> permission denied error. The result of this was the dhcp client would
> fail to send the renewal request and so the dhcp lease would expire.
> =

> The addition of the CAP_NET_BIND_SERVICE capability allows the service
> to open sockets in the restricted port range (<1024) which is required
> for dhcp.
> ---
>   src/iwd.service.in | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Regards,
-Denis

--===============3397222177380295726==--

