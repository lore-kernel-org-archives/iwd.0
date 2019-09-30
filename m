Content-Type: multipart/mixed; boundary="===============4545616680179201553=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/8] netconfig: Decouple from station state
Date: Mon, 30 Sep 2019 15:12:08 -0500
Message-ID: <4457e580-4ad5-8530-0b4e-06c23f4306e9@gmail.com>
In-Reply-To: <20190930163558.28123-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4545616680179201553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 9/30/19 11:35 AM, Tim Kourt wrote:
> Instead of relying on station state changed signal, netconfig
> introduces three new API calls to configure, re-configure and
> reset the network configurations. The owner of netconfig object
> is responsible for initiating the re-configuration of the device
> depending on its state.
> ---
>   src/netconfig.c | 79 ++++++++++++++++++++++++++++++--------------------=
-------
>   src/netconfig.h |  6 +++++
>   2 files changed, 48 insertions(+), 37 deletions(-)
> =


Patches 1-3 applied, thanks.

Regards,
-Denis

--===============4545616680179201553==--

