Content-Type: multipart/mixed; boundary="===============0018393249308719881=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/4] client: special case daemon interface for
 non-interactive
Date: Tue, 02 Nov 2021 16:15:27 -0500
Message-ID: <f9a38226-27af-4a88-e2a9-f0cd45335da0@gmail.com>
In-Reply-To: 20211102195752.381604-1-prestwoj@gmail.com

--===============0018393249308719881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/2/21 2:57 PM, James Prestwood wrote:
> In non-interactive mode, when a dbus method call returns the process
> exits. This is true for all methods except agent requests since e.g.
> Connect() call automatically requests credentials and the client must
> wait for that to return before exiting. The new daemon interface must
> also be treated in the same way and not exit.
> ---
>   client/dbus-proxy.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> =


All applied, thanks.

Regards,
-Denis

--===============0018393249308719881==--

