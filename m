Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B903209
	for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 17:00:49 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id gf8so10288012pjb.5
        for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKabqpmjph9pHKRDyJjP7h5ZFZ8IO/F6kT022+JXiCQ=;
        b=bXzPmljJGEh1jw8CaAF2tEOyTuzqsnzSy4aF7UlvwpkfEpOGoJPLNscqJrVhC8Blrb
         ylsyOPqsWq8zTmME/80PaC5rA7uOdZuEz13sEBRIDuZ2xNn+sAk6Nni41Lrx/hA7714x
         4Vlw5Mhp8Pm/Cz1Syon45wvd743Ym4l048mVFP5lW5mZpfMyugw/Zlq7cdr3nWi0m5gu
         jiHXf4jASF2asKaSl4v8z48acxwtK1rdF4fETzNjC29tMLG8GV7rz7AkfVhP9wYHCP4j
         ahcWy0PbyVL8NnTahSPytA6bkIasS3OB3pcE2sjjQbgvU3kghdQe3ZX8IohgvAOi4f5a
         QbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DKabqpmjph9pHKRDyJjP7h5ZFZ8IO/F6kT022+JXiCQ=;
        b=EPz1kHbykbhsyMd8FblVL5IZt/l5P1UgMNm7iuvMvzC371RYB5W526uD9/eY/eUrq+
         biCMhIgzHKTnaC7z9skW9w98kzRyblNjIwJDLhs1gHXm4u9nPx8w5DkovmJrD88Lkc3x
         gfCoWm5ALdMLMIvIiv4b8v7hrp71p400Me6ve98B1OsBDVM+uFFjdtn2YxWD92v4el5p
         jj71WEY5UF+R/TeR+cRnt/Tu33OkJieBAKxDg+1f6/Spd41/BGWZDHGMUdvhNe5dtrWW
         x9ogPF+gcGo+/G5un0rmHbimGy31YtJUa1lqKVWj799tWD43S7bO5x1k2jgjAFmq6d6n
         dBpw==
X-Gm-Message-State: ACrzQf2hTKejOzB2WI+pIK1l1Cd5oUuPZG4D2kz0HcFK1zzQnzxoDwsq
	IJgZBZy8Z/JQPxdr39xzp6JBjqABFeM=
X-Google-Smtp-Source: AMsMyM53HzyG/hlh4crsFbQS5HsgEQLdiDvlDxkkmhrUdPfPhVGsh1fcidNwLyJa7B4vUf6e6TNpNg==
X-Received: by 2002:a17:90a:7b8c:b0:20b:1f3b:f6fd with SMTP id z12-20020a17090a7b8c00b0020b1f3bf6fdmr21286410pjc.202.1665421249028;
        Mon, 10 Oct 2022 10:00:49 -0700 (PDT)
Received: from [192.168.254.15] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z10-20020a630a4a000000b004388ba7e5a9sm6618812pgk.49.2022.10.10.10.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:00:48 -0700 (PDT)
Message-ID: <0a53a6affe3d8f34ac08b95f307de3ac1c674635.camel@gmail.com>
Subject: Re: [PATCH] client: handle wide chars for table rows
From: James Prestwood <prestwoj@gmail.com>
To: Pinghao Wu <xdavidwuph@gmail.com>, iwd@lists.linux.dev
Date: Mon, 10 Oct 2022 10:00:48 -0700
In-Reply-To: <20221008075509.26252-1-xdavidwuph@gmail.com>
References: <20221008075509.26252-1-xdavidwuph@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2022-10-08 at 15:55 +0800, Pinghao Wu wrote:
> Try to find out printing width of wide chars using current locale and
> its byte length before falling back to non-codepoint UTF-8 bytes
> method.
> ---
>  client/display.c | 16 +++++++++++++++-
>  client/main.c    |  3 +++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/client/display.c b/client/display.c
> index b729ad4c..dcbe11f8 100644
> --- a/client/display.c
> +++ b/client/display.c
> @@ -26,10 +26,13 @@
>  
>  #define _GNU_SOURCE
>  #include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
>  #include <signal.h>
>  #include <sys/stat.h>
>  #include <sys/ioctl.h>
>  #include <unistd.h>
> +#include <wchar.h>
>  
>  #include <readline/history.h>
>  #include <readline/readline.h>
> @@ -401,15 +404,26 @@ static char* next_line(char *s, unsigned int
> *max, char **color_out)
>         unsigned int i;
>         int last_space = -1;
>         int last_color = -1;
> +       int s_len = strlen(s);
>  
>         /* Find the last space before 'max', as well as any color */
> -       for (i = 0; i <= *max && s[i] != '\0'; i++) {
> +       for (i = 0; i <= *max && i != s_len; i++) {
>                 if (s[i] == ' ')
>                         last_space = i;
>                 else if (s[i] == 0x1b) {
>                         /* color escape won't count for column width
> */
>                         *max += color_end(s + i);
>                         last_color = i;
> +               /* Non-ASCII, try wchar */
> +               } else if (s[i] & 0x80) {
> +                       wchar_t w;
> +                       int w_mblen;
> +                       if ((w_mblen = mbtowc(&w, &s[i], s_len - i))

Instead of mbtowc() use l_utf8_get_codepoint() (an ELL utility). Since
we assume the input is going to be utf-8 always.

> > 0) {
> +                               /* Compensate max bytes for wide char
> */
> +                               *max += w_mblen - wcwidth(w);
> +                               /* Skip other bytes for this wchar */
> +                               i += w_mblen - 1;
> +                       }
>                 /* Add width for non-codepoint UTF-8 bytes */
>                 } else if (((uint8_t)s[i] >> 6) == 2)
>                         *max += 1;

And you can go ahead and remove this if-clause entirely since the above
case should now cover it. Plus the s[i] & 0x80 check above actually
prevents this branch from ever being taken.

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

Thanks,
James


