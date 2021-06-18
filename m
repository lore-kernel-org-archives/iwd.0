Content-Type: multipart/mixed; boundary="===============7992627311410295911=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] station: Remove diagnostics interface reliably
Date: Fri, 18 Jun 2021 10:07:25 -0500
Message-ID: <fca51731-3f46-9ef3-37d3-f84c082028aa@gmail.com>
In-Reply-To: <20210618073324.67095-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7992627311410295911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 6/18/21 2:33 AM, Andrew Zaborowski wrote:
> If the idea is that the interface should only be present when connected
> then don't do this in the DISCONNECTING state as there are various
> possible transitions from CONNECTED or ROAMING directly to DISCONNECTED.
> ---
>   src/station.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis
--===============7992627311410295911==--

