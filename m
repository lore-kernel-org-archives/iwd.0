Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5B84A0D
	for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 19:22:24 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id m81so13709649oia.1
        for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIo2j1Sp0C4ma2cvpE8DWBNqLTlKCDs5ZgKMV5azbs0=;
        b=QKSGsIYz62VAwaqssbHShIP9DY5a2LgL89Z4n/zi4gF7LZBXCKVemQGF1HGFy4qVAd
         MthI25VkdvkayxI8ILHqtMKnHejEGNPQo76HPgmr2UddhASdJr5Kr/u0xwOujPbP2i86
         //G9PjW4YUDpqYPmNAqwouO59Hz/yWmnRm6wFsHLzy5LltjPpn/Mrfm2MF2uIgUFjzkt
         A6baG6mwyzrLsNyhwIV/31M9IbyavabXvB1+dlIXEh4gkfp2SpWE9zQ0jvEXixMD2NCk
         OH+1rGG0lev1FCJzWK+E7Qt53r/9cNAN/SqdTWkqgOfheTfB6zWVlAdp/jERmHFB1haz
         Gx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eIo2j1Sp0C4ma2cvpE8DWBNqLTlKCDs5ZgKMV5azbs0=;
        b=FOPAgR3QnVLQGt6eV3YMnAEI8zD9ovuUaGOsvYV/Kq14Dq1CvDhrk78Cg9ol5tQBZ+
         Kb7N1GAHC0HuE3XKmeQrGJVxGiHqnUl5glfRSokSkl6exiMLuNKkR9h/LOtX26zWN3nC
         zizcJ8SZWrtZFjwjyDNluB1Dmjl9EX2K6WPyPxHx8TeDFuoMH/GHBZJM5abmytCRYnx2
         yrz+e7s4ODPxmU3GVtG3SGTvPhXjdfll1QzfqroWpQRHd9C86M1qpuCUhvE1U6Iv7Hkb
         2vrVkGAZGa8QTn3RWdQayoGgnKxL5v0zNeP9MF0ZvldNznf5En5K/M1iC/WcpNeigJva
         ZVug==
X-Gm-Message-State: ACrzQf3de9CSfkpCi6y3c0GQztEKL7poLk4/s6VCykMaLlvQbM86t8Mj
	rZtZJXebbZqynjz3TL0G5x5a5sMNYAc=
X-Google-Smtp-Source: AMsMyM6Wftyua450Mw4qSs27+EIzhsPqLa0bMA+g/TaHKb6WAzIcyT79H4wzpBos8BbZDESV8AFvhg==
X-Received: by 2002:a17:90a:d983:b0:20a:ec04:e028 with SMTP id d3-20020a17090ad98300b0020aec04e028mr30954574pjv.122.1665429733206;
        Mon, 10 Oct 2022 12:22:13 -0700 (PDT)
Received: from [192.168.254.27] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ea8200b0016d5b7fb02esm7015975plb.60.2022.10.10.12.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:22:12 -0700 (PDT)
Message-ID: <0fab6902a2be0abc659094dd8fb379cee2101840.camel@gmail.com>
Subject: Re: [PATCH v2] client: handle wide chars for table rows
From: James Prestwood <prestwoj@gmail.com>
To: Pinghao Wu <xdavidwuph@gmail.com>, iwd@lists.linux.dev
Date: Mon, 10 Oct 2022 12:22:12 -0700
In-Reply-To: <20221010182603.55042-1-xdavidwuph@gmail.com>
References: <20221010182603.55042-1-xdavidwuph@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Pinghao,

On Tue, 2022-10-11 at 02:26 +0800, Pinghao Wu wrote:
> Find out printing width of wide chars via wcwidth().
> ---
>  client/display.c | 18 ++++++++++++++----
>  client/main.c    |  3 +++
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/client/display.c b/client/display.c
> index b729ad4c..42b5336e 100644
> --- a/client/display.c
> +++ b/client/display.c
> @@ -30,6 +30,7 @@
>  #include <sys/stat.h>
>  #include <sys/ioctl.h>
>  #include <unistd.h>
> +#include <wchar.h>
>  
>  #include <readline/history.h>
>  #include <readline/readline.h>
> @@ -401,18 +402,27 @@ static char* next_line(char *s, unsigned int
> *max, char **color_out)
>         unsigned int i;
>         int last_space = -1;
>         int last_color = -1;
> +       int s_len = strlen(s);
>  
>         /* Find the last space before 'max', as well as any color */
> -       for (i = 0; i <= *max && s[i] != '\0'; i++) {
> +       for (i = 0; i <= *max && i != s_len; i++) {

I know you didn't write the for-loop originally, but now since you're
incrementing i by some value larger than 1 it makes more sense to use a
while loop and break out if i > *max. In addition I think you could
blow past the i != s_len check.

I think this entire thing could be simplified now with you're changes
by putting l_utf8_get_codepoint into a while loop and always calling
wcwidth() for each character. Then we aren't distinguishing between
ascii and utf-8, just always increment i/max by the needed values (also
taking into account the space/color checks obviously).

>                 if (s[i] == ' ')
>                         last_space = i;
>                 else if (s[i] == 0x1b) {
>                         /* color escape won't count for column width
> */
>                         *max += color_end(s + i);
>                         last_color = i;
> -               /* Add width for non-codepoint UTF-8 bytes */
> -               } else if (((uint8_t)s[i] >> 6) == 2)
> -                       *max += 1;
> +               /* Non-ASCII */
> +               } else if (s[i] & 0x80) {
> +                       wchar_t w;
> +                       int w_mblen = l_utf8_get_codepoint(&s[i],
> s_len - i, &w);
> +                       if (w_mblen > 0) {
> +                               /* Compensate max bytes */
> +                               *max += w_mblen - wcwidth(w);
> +                               /* Skip other bytes of this codepoint
> */
> +                               i += w_mblen - 1;
> +                       }
> +               }
>         }
>  
>         /* Reached the end of the string within the column bounds */
> diff --git a/client/main.c b/client/main.c
> index df5c0a61..7e8dead4 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -25,6 +25,7 @@
>  #endif
>  
>  #include <errno.h>
> +#include <locale.h>
>  #include <signal.h>
>  #include <ell/ell.h>
>  
> @@ -50,6 +51,8 @@ int main(int argc, char *argv[])
>  {
>         bool all_done;
>  
> +       setlocale(LC_CTYPE, "");
> +
>         if (!l_main_init())
>                 return EXIT_FAILURE;
>  


