Content-Type: multipart/mixed; boundary="===============6710255441415393466=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 2/2] test-runner: fix logging directory name
Date: Wed, 06 Nov 2019 13:41:55 -0800
Message-ID: <e8afdd7b06c672ddd1f7e7af0529c3c4cbf76022.camel@gmail.com>
In-Reply-To: <20191106213815.20555-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6710255441415393466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-06 at 13:38 -0800, James Prestwood wrote:
> localtime indexes month starting at zero so adding 1 gives us a
> folder
> name with the correct month.
> ---
>  tools/test-runner.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index 1c807aea..163f53e7 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -3184,7 +3184,7 @@ int main(int argc, char *argv[])
>  =

>  			snprintf(log_dir, sizeof(log_dir), "%s/run-%d-
> %d-%d-%d",
>  					optarg, timeinfo->tm_year,
> -					timeinfo->tm_mon, timeinfo-
> >tm_mday,
> +					timeinfo->tm_mon + 1, timeinfo-
> >tm_mday,
>  					getpid());

I just realized that the year is not really correct either. localtime
uses years since 1900, so e.g. for 2019 you get 119. Will fix this in
v2.

>  			mkdir(log_dir, 0755);
> =20

--===============6710255441415393466==--

