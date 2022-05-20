Content-Type: multipart/mixed; boundary="===============5676443382234570227=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/2] Initial signal level notification
Date: Fri, 20 May 2022 15:11:55 -0500
Message-ID: <a5abf8cf-ab6e-7ea5-a458-f5d629f18561@gmail.com>
In-Reply-To: 20220520185948.9533-1-jesse@twosheds.org

--===============5676443382234570227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

On 5/20/22 13:59, Jesse Lentz wrote:
> After registration of a SignalLevelAgent, make iwd inform the client of
> the initial signal level via a "Changed" method call.
> ---
>   src/netdev.c  |  5 +++++
>   src/netdev.h  |  1 +
>   src/station.c | 16 ++++++++++++----
>   3 files changed, 18 insertions(+), 4 deletions(-)
> =


<snip>

> diff --git a/src/station.c b/src/station.c
> index 2d85054c..7be256fe 100644
> --- a/src/station.c
> +++ b/src/station.c

<snip>

> @@ -3758,10 +3768,8 @@ static struct l_dbus_message *station_dbus_signal_=
agent_register(
>   =

>   	l_debug("agent %s path %s", sender, path);
>   =

> -	/*
> -	 * TODO: send an initial notification in a oneshot idle callback,
> -	 * if state is connected.
> -	 */
> +	if (station->connected_network)
> +		l_idle_oneshot(signal_agent_notify_initial, station, NULL);
>   =

>   	return l_dbus_message_new_method_return(message);

I'd rather not use l_idle_oneshot here.  There's a astronomically tiny chan=
ce =

that station will be wiped out before the idle callback fires on the next l=
oop =

iteration.  It should also be easy to avoid:

struct l_dbus_message *reply;

...

reply =3D l_dbus_message_new_method_return(message);
l_dbus_send(dbus, reply);

if (station->connected_network)
	station_signal_agent_notify(...);

return NULL;

This ensures the reply goes out prior to the Changed method being invoked.

>   }
> =


Regards,
-Denis
--===============5676443382234570227==--

