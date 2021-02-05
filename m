Content-Type: multipart/mixed; boundary="===============3049048547745480139=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/2] station: move scan cancelation to
 __station_connect_network
Date: Thu, 04 Feb 2021 20:57:00 -0600
Message-ID: <d6e666b9-0027-dab8-3c74-1ec20378ae6b@gmail.com>
In-Reply-To: <20210205000603.241826-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3049048547745480139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/4/21 6:06 PM, James Prestwood wrote:
> An earlier patch fixed a problem where a queued quick scan would
> be triggered and fail once already connected, resulting in a state
> transition from connected --> autoconnect_full. This fixed the
> Connect() path but this could also happen via autoconnect. Starting
> from a connected state, the sequence goes:
> =

>   - DBus scan is triggered
>   - AP disconnects IWD
>   - State transition from disconnected --> autoconnect_quick
>   - Queue quick scan
>   - DBus scan results come in and used to autoconnect
>   - A connect work item is inserted ahead of all others, transition
>     from autoconnect_quick --> connecting.
>   - Connect completes, transition from connecting --> connected
>   - Quick scan can finally get triggered, which the kernel fails to
>     do since IWD is connected, transition from connected -->
>     autoconnect_full.
> =

> This can be fixed by checking for a pending quick scan in the
> autoconnect path.
> ---
>   src/station.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Both applied, thanks.

Regards,
-Denis

--===============3049048547745480139==--

