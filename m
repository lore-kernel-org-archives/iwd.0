Content-Type: multipart/mixed; boundary="===============0763837326741469389=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 01/12] main: move module init into nl80211_appeared
Date: Fri, 11 Oct 2019 15:49:28 -0500
Message-ID: <ebc85cc8-8d89-90ac-b6b7-05cac1372e41@gmail.com>
In-Reply-To: <20191011192933.13550-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0763837326741469389==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/11/19 2:29 PM, James Prestwood wrote:
> In preparation for integrating IWD_MODULE into modules which require
> nl80211 we move the module init into the nl80211_appeared callback.
> This will guarentee that the nl80211 is available during module init
> and allow modules to get their own copy of nl80211 rather than needing
> a set function (e.g. netdev_set_nl80211).
> =

> Since the dbus name request callback happens before this as well any
> dbus module can also use IWD_MODULE and simply assume the dbus object
> is ready.
> =

> plugin_init was also deferred to nl80211_appeared since some plugins
> depend on modules being initialized.
> ---
>   src/main.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> =

> -v2:
>   * Moved plugin_init after iwd_modules_init
> =


All applied, thanks.

Regards,
-Denis

--===============0763837326741469389==--

