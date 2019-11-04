Content-Type: multipart/mixed; boundary="===============6047992658680794635=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] auto-t: support hostapd event processing
Date: Mon, 04 Nov 2019 14:42:40 -0600
Message-ID: <9f12b536-692f-ff5c-1e79-958be316dba6@gmail.com>
In-Reply-To: <20191029175043.27745-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6047992658680794635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/29/19 12:50 PM, James Prestwood wrote:
> Hostapd has a feature where you can connect to its control socket and
> receive events it generates. Currently we only send commands via this
> socket.
> =

> First we open the socket (/var/run/hostapd/<iface>) and send the
> ATTACH command. This tells hostapd we are ready and after this any
> events will be sent over this socket.
> =

> A new API, wait_for_event, was added which takes an event string and
> waits for some timeout. The glib event loop has been integrated into
> this, though its not technically async since we are selecting over a
> socket which blocks. To mitigate this a small timeout was chosen for
> each select call and then wrapped in a while loop which waits for the
> full timeout.
> ---
>   autotests/util/hostapd.py | 68 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============6047992658680794635==--

