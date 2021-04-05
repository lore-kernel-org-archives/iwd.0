Content-Type: multipart/mixed; boundary="===============7148631272698277526=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] sae: remove authenticate timeout handler
Date: Mon, 05 Apr 2021 17:49:13 -0500
Message-ID: <64179799-f9b6-7739-680e-306a7957ec63@gmail.com>
In-Reply-To: <20210405224027.1052197-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7148631272698277526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/5/21 5:40 PM, James Prestwood wrote:
> This fixes an infinite loop issue when authenticate frames time
> out. If the AP is not responding IWD ends up retrying indefinitely
> due to how SAE was handling this timeout. Inside sae_auth_timeout
> it was actually sending another authenticate frame to reject
> the SAE handshake. This, again, resulted in a timeout which called
> the SAE timeout handler and repeated indefinitely.
> =

> The kernel resend behavior was not taken into account when writing
> the SAE timeout behavior and in practice there is actually no need
> for SAE to do much of anything in response to a timeout. The
> kernel automatically resends Authenticate frames 3 times which mirrors
> IWDs SAE behavior anyways. Because of this the authenticate timeout
> handler can be completely removed, which will cause the connection
> to fail in the case of an autentication timeout.
> ---
>   src/sae.c | 30 ------------------------------
>   1 file changed, 30 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============7148631272698277526==--

