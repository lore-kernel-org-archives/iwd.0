Content-Type: multipart/mixed; boundary="===============7741253203150065552=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 06/16] handshake: Convert HANDSHAKE_EVENT_FAILED data to
 int
Date: Wed, 30 Oct 2019 14:26:45 -0500
Message-ID: <2f4e2a44-0e81-f4e3-3b66-e15256eab6b1@gmail.com>
In-Reply-To: <20191028140508.13518-6-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7741253203150065552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/28/19 9:04 AM, Andrew Zaborowski wrote:
> Note the uint16_t reason code is promoted to an int when using variable
> arguments so va_arg(args, int) has to be used.
> ---
>   src/ap.c      | 2 +-
>   src/eapol.c   | 2 +-
>   src/station.c | 2 +-
>   src/wsc.c     | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> =


Ah, you did this part as a separate patch.  Should have looked again.

I squashed patchees 5, 6, and 7 together and applied.

Regards,
-Denis
--===============7741253203150065552==--

