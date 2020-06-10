Content-Type: multipart/mixed; boundary="===============7556529871425163317=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/3] station: Use separate msg holder for hidden
 connections
Date: Tue, 09 Jun 2020 21:59:13 -0500
Message-ID: <94c5eb9f-7502-b0eb-c52f-7ca3419e09c1@gmail.com>
In-Reply-To: <20200610012221.19263-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7556529871425163317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 6/9/20 8:22 PM, Tim Kourt wrote:
> Introduce hidden_pending to keep reference to the dbus message object
> while we wait for the scan results to be returned while trying to
> connect to a hidden network. This simplifies the logic by separating it
> into two independent logical units: scanning, connecting and eliminates
> a possibility of a memory leak in the case when Network.Connect being
> initiated while Station.ConnectHiddenNetwork is in progress.
> ---
>   src/station.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============7556529871425163317==--

