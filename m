Content-Type: multipart/mixed; boundary="===============6294112280761963300=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: hostapd.py: remove _hostapd_restarted concept
Date: Mon, 16 Aug 2021 11:33:50 -0500
Message-ID: <de2f8f7b-f64d-ff01-6327-dc69b0f1d685@gmail.com>
In-Reply-To: <20210816160450.11566-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6294112280761963300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/16/21 11:04 AM, James Prestwood wrote:
> The destructor was trying to do more than the scope of a destructor
> by trying to handle this single case of hostapd being restarted.
> =

> Instead we can simply pass a keyword argument 'reinit' to the
> constructor to tell it to reinitialize everything. And as for killing
> hostapd this can be done in ungraceful_restart itself rather than
> trying to handle it in the destructor.
> ---
>   autotests/util/hostapd.py | 21 +++++++--------------
>   1 file changed, 7 insertions(+), 14 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6294112280761963300==--

