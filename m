Content-Type: multipart/mixed; boundary="===============5146418271937964055=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netdev: use l_idle_create for disconnect idle
Date: Tue, 06 Apr 2021 12:32:58 -0500
Message-ID: <961d402b-670c-3dde-51b2-6fd2a2689cab@gmail.com>
In-Reply-To: <20210406165826.1082128-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5146418271937964055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/6/21 11:58 AM, James Prestwood wrote:
> The chances were extremely low, but using l_idle_oneshot
> could end up causing a invalid memory access if the netdev
> went down while waiting for the disconnect idle callback.
> =

> Instead netdev can keep track of the idle with l_idle_create
> and remove it if the netdev goes down prior to the idle callback.
> ---
>   src/netdev.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============5146418271937964055==--

