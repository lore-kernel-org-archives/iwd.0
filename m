Content-Type: multipart/mixed; boundary="===============2979625322262942903=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] client: Reorder interface creation ops
Date: Thu, 27 Feb 2020 16:31:42 -0600
Message-ID: <df246662-5708-cb44-8cbd-1fcdd46101c4@gmail.com>
In-Reply-To: <20200226233224.31261-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2979625322262942903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 2/26/20 5:32 PM, Tim Kourt wrote:
> Add the newly created proxy objects into the queue before the
> interface specific initialization logic takes place. This way the new
> proxy objects can be used within the initialization procedures.
> ---
>   client/dbus-proxy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Both applied, thanks.

Regards,
-Denis

--===============2979625322262942903==--

