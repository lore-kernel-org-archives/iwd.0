Content-Type: multipart/mixed; boundary="===============7596852430761479170=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 6/7] doc: document [General].RoamThreshold5G
Date: Mon, 10 May 2021 10:13:42 -0500
Message-ID: <b34f6ce5-936a-52ff-79de-ed22551cbe18@gmail.com>
In-Reply-To: <20210507202620.93540-6-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7596852430761479170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/7/21 3:26 PM, James Prestwood wrote:
> ---
>   src/iwd.config.rst | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> =

> diff --git a/src/iwd.config.rst b/src/iwd.config.rst
> index 478bd616..8e3662d4 100644
> --- a/src/iwd.config.rst
> +++ b/src/iwd.config.rst
> @@ -131,7 +131,14 @@ The group ``[General]`` contains general settings.
>      * - RoamThreshold
>        - Value: rssi dBm value, from -100 to 1, default: **-70**
>   =

> -       This can be used to control how aggressively **iwd** roams.
> +       This can be used to control how aggressively **iwd** roams from 2=
.4Ghz

I reworded this slightly to read:
This value can be used to control how aggressively **iwd** roams when conne=
cted =

to a 2.4Ghz access point.

> +       networks.
> +
> +   * - RoamThreshold5G
> +     - Value: rssi dBm value, from -100 to 1, default: **-76**
> +
> +       This value can be used to control how aggressively **iwd** roams =
from
> +       5GHz networks.

ditto.

>   =

>      * - RoamRetryInterval
>        - Value: unsigned int value in seconds (default: **60**)
> =


applied, thanks.

Regards,
-Denis
--===============7596852430761479170==--

