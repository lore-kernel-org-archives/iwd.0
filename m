Content-Type: multipart/mixed; boundary="===============6655279216826665849=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] dbus: Remove 'at_console', add 'netdev' settings
Date: Wed, 26 Jan 2022 14:06:39 -0600
Message-ID: <e96d0cc9-5eee-8f33-a92b-9291ec5dc086@gmail.com>
In-Reply-To: 20220126200103.16017-1-didi.debian@cknow.org

--===============6655279216826665849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Diederik,

On 1/26/22 14:01, Diederik de Haas wrote:
> The 'at_console' D-Bus policy setting has been deprecated for more then
> 10 years and could be ignored at any time in the future. Moreover, while
> the intend was to allow locally logged on users to interact with iwd, it
> didn't actually do that.
> More info at https://www.spinics.net/lists/linux-bluetooth/msg75267.html
> and https://gitlab.freedesktop.org/dbus/dbus/-/issues/52
> Therefor remove the 'at_console' setting block.
> =

> On Debian (based) systems, there is a standard defined group which is
> allowed to manage network interfaces, and that is the 'netdev' group.
> So add a D-Bus setting block to grant the 'netdev' group that access.
> ---
> Changes since v1:
> - Added 'dbus' prefix to primary commit message and shortened it to
>    less then 50 chars
> - Reformatted secondary commit message to max 72 chars and fixed a
>    small typo (_ -> ')
> =

>   src/iwd-dbus.conf | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6655279216826665849==--

