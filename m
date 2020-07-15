Content-Type: multipart/mixed; boundary="===============9221668306557369232=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] auto-t: fix hostapd.ungraceful_restart
Date: Wed, 15 Jul 2020 14:44:11 -0500
Message-ID: <2cd0d2f0-e565-6d76-636d-0ac1cf9e59d8@gmail.com>
In-Reply-To: <20200714184908.2776-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9221668306557369232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 7/14/20 1:49 PM, James Prestwood wrote:
> Restarting hostapd from python was actually leaking memory and
> causing the hostapd object to stay referenced in python. The
> GLib timeout in wait_for_event was the ultimate cause, but this
> had no come to light because no tests restarted hostapd then
> used wait_for_event.
> =

> In addition, any use of wait_for_event after a restart would
> cause an exception because the event socket was never re-attached
> after hostapd restarted.
> =

> Now we properly clean up the timeout in wait_for_event and
> re-initialize the hostapd object on restart.
> ---
>   autotests/util/hostapd.py | 39 +++++++++++++++++++++++++++++----------
>   1 file changed, 29 insertions(+), 10 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============9221668306557369232==--

