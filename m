Content-Type: multipart/mixed; boundary="===============0370871741309100261=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] manager: Make sure all interface are processed after
 dump
Date: Mon, 27 Jan 2020 15:01:19 -0600
Message-ID: <3a2c3028-99e2-8528-741f-1e528027aaa2@gmail.com>
In-Reply-To: <20200127141646.316-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0370871741309100261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/27/20 8:16 AM, Andrew Zaborowski wrote:
> In manager_interface_dump_done use l_queue_foreach_remove instead of
> l_queue_remove_if to make sure we process all of the interfaces.
> ---
>   src/manager.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0370871741309100261==--

