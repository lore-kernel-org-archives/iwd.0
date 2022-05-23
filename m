Content-Type: multipart/mixed; boundary="===============0556152682483097580=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/2] station: Simplify usage of
 station_signal_agent_notify()
Date: Mon, 23 May 2022 12:57:25 -0500
Message-ID: <f3aecafc-8274-e374-648a-a6d267ba58c5@gmail.com>
In-Reply-To: 20220523062053.16206-1-jesse@twosheds.org

--===============0556152682483097580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

On 5/23/22 01:20, Jesse Lentz wrote:
> station_signal_agent_notify() has been refactored so that its usage is
> simpler. station_rssi_level_changed() has been replaced by an inlined
> call to station_signal_agent_notify().
> ---
>   src/station.c | 38 ++++++++++++--------------------------
>   1 file changed, 12 insertions(+), 26 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============0556152682483097580==--

