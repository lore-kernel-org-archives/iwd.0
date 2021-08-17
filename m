Content-Type: multipart/mixed; boundary="===============3891950753289159548=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] network: destroy secrets on network_disconnect()
Date: Tue, 17 Aug 2021 09:26:03 -0500
Message-ID: <6dc6f120-0ad2-4857-8e3c-ef4012ed3239@gmail.com>
In-Reply-To: <20210816235823.146856-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3891950753289159548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/16/21 6:58 PM, James Prestwood wrote:
> ---
>   src/network.c | 2 ++
>   1 file changed, 2 insertions(+)
> =

> diff --git a/src/network.c b/src/network.c
> index 20c0ee1f..2779f6be 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -192,6 +192,8 @@ void network_disconnected(struct network *network)
>   	network_settings_close(network);
>   =

>   	l_queue_clear(network->blacklist, NULL);
> +	l_queue_destroy(network->secrets, eap_secret_info_free);
> +	network->secrets =3D NULL;

This seems to be the wrong place for this?  The intent in network_connected=
() =

and network_connect_failed() seems to be to free secrets if the connection =

failed, and remove any non-cacheable secrets if we succeeded.  But otherwis=
e the =

secrets are cached for the life of the network.

Consider a case where you connect to A (grabbing secrets from the user), th=
en =

switch to another network, then switch back to A.  The second connection to=
 A =

should work without asking for secrets again.

This commit would seem to break the above?

>   }
>   =

>   /* First 64 entries calculated by 1 / pow(n, 0.3) for n >=3D 1 */
> =


Regards,
-Denis
--===============3891950753289159548==--

