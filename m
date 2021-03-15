Content-Type: multipart/mixed; boundary="===============2281122476023077806=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] network: add network_bss_update
Date: Mon, 15 Mar 2021 15:33:44 -0500
Message-ID: <a4746d0d-9f12-8ba0-03e8-c3dff467b1e8@gmail.com>
In-Reply-To: <20210315191529.186554-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2281122476023077806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/15/21 2:15 PM, James Prestwood wrote:
> This will swap out a scan_bss object with a duplicate that may
> exist in a networks bss_list. The duplicate will be removed by
> since the object is owned by station it is assumed that it will
> be freed elsewhere.
> ---
>   src/network.c | 21 +++++++++++++++++++++
>   src/network.h |  1 +
>   2 files changed, 22 insertions(+)
> =


All applied, thanks.

Regards,
-Denis

--===============2281122476023077806==--

