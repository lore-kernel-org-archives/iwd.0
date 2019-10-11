Content-Type: multipart/mixed; boundary="===============6886133473406527081=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 05/11] agent: utilize IWD_MODULE
Date: Fri, 11 Oct 2019 13:53:26 -0500
Message-ID: <34b2cb3f-630c-5bf8-96a3-0af8154fcd0d@gmail.com>
In-Reply-To: <20191011172417.23328-5-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6886133473406527081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/11/19 12:24 PM, James Prestwood wrote:
> Converts agent into an IWD module. This removes the dbus dependency
> on agent. Since dbus is initialized very early we can assume
> dbus_get_bus is going to return a valid object.
> ---
>   src/agent.c | 19 ++++++++++++-------
>   src/agent.h |  2 --
>   src/dbus.c  |  3 +--
>   3 files changed, 13 insertions(+), 11 deletions(-)
> =


Applied, thanks.

Regards,
-Denis
--===============6886133473406527081==--

