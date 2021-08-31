Content-Type: multipart/mixed; boundary="===============4336224717723369730=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ap: Add MACs to FILS IP Assignment responses
Date: Tue, 31 Aug 2021 10:10:34 -0500
Message-ID: <6989cdbb-0151-c8de-02ef-2f94fc249a6b@gmail.com>
In-Reply-To: <20210828032305.29788-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4336224717723369730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/27/21 10:23 PM, Andrew Zaborowski wrote:
> Try to include the gateway and DNS MAC addresses in the corresponding
> fields in the FILS IP Address Assignment IEs we send to the clients.
> ---
>   src/ap.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 122 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============4336224717723369730==--

