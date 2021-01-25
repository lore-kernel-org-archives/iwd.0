Content-Type: multipart/mixed; boundary="===============3139927801184643192=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: fix wait_for_object_condition
Date: Mon, 25 Jan 2021 13:11:13 -0600
Message-ID: <c3745e14-1fae-b333-7cdc-59efa0c54627@gmail.com>
In-Reply-To: <20210125180528.803024-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3139927801184643192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/25/21 12:05 PM, James Prestwood wrote:
> After the re-write this was broken and not noticed until
> recently. The issue appeared to be that the GLib timeout
> callback retained no context of local variables. Previously
> _wait_timed_out was set as a class variable, but this was
> removed so multiple IWD instances could work. Without
> _wait_timed_out being a class variable the GLib timeout
> setting it had no effect on the wait loop.
> =

> To fix this we can set _wait_timed_out on the object being
> passed in. This is preserved in the GLib timeout callback
> and setting it gets honored in the wait loop.
> ---
>   autotests/util/iwd.py | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> =


Applied, thanks.

Regards,
Denis

--===============3139927801184643192==--

