Content-Type: multipart/mixed; boundary="===============2685422448791504796=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/8] netdev: move netdev_station_info to diagnostic.h
Date: Fri, 22 Jan 2021 15:03:51 -0600
Message-ID: <4dc70eb7-a984-21b8-524b-a0cb1ad55d9b@gmail.com>
In-Reply-To: <20210122203849.679952-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2685422448791504796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/22/21 2:38 PM, James Prestwood wrote:
> With AP now getting its own diagnostic interface it made sense
> to move the netdev_station_info struct definition into its own
> header which eventually can be accompanied by utilities in
> diagnostic.c. These utilities can then be shared with AP and
> station as needed.
> ---
>   src/diagnostic.h | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
>   src/netdev.c     | 23 ++++++++++++-----------
>   src/netdev.h     | 34 ++++-----------------------------
>   src/station.c    | 18 ++++++++++--------
>   4 files changed, 75 insertions(+), 49 deletions(-)
>   create mode 100644 src/diagnostic.h
> =

> v4:
>   * Fixed station.c so it complies
> =


All applied now.  I fixed up some copyright notices to  read 2021 instead o=
f 2020.

Regards,
-Denis

--===============2685422448791504796==--

