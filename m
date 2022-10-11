Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21B3C32
	for <iwd@lists.linux.dev>; Tue, 11 Oct 2022 16:55:06 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id x6so13749801pll.11
        for <iwd@lists.linux.dev>; Tue, 11 Oct 2022 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNFrnqaCaApEVjFxRHK87W82VlDS6ni5/ie8BBq9NmE=;
        b=qCsO7xH7PKaHqNCepzzRYDrWBDQwxD4gnEwoVhScnyz8ckwdx8qyqoMemYs5NF6Ae+
         iCs6BT7gju637wWCf5r6Q1gPY89trV0HZmeMp8QFV5vvQG3B2xjOUOqtXjpD/a16rVvE
         /Z9G8bWSEMj2HqXu7arspvnM42F0tFYCCSC5Lnv11mbAD+ADAlhui4n9iDBThBHF2Tsg
         oOExczoPEAOljtsUc78c7EibeTqREa3qH65ie7VftVBjj3bUat66iFHhyKXh2jMM3oln
         QXUHY+iIZt75BfyDm5aTckloSi+7i5o+ncNZC8/kC4HGxs7fM/LfcaJdDHLT7J/mQvwB
         xYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NNFrnqaCaApEVjFxRHK87W82VlDS6ni5/ie8BBq9NmE=;
        b=PLOPmFqNwUOhvftSI82Nf1UjM/WdoqVBKEBdTLDk6wyExwSdPcKTZ4DRDCiMS4ebvy
         DYdQC66eCginbPgtYbyy0xP1Ov6KXkR7r00LkG9c/zECO4A19TA8Mt37Guv5flhZskjj
         TXI9ELMGc10HwlJ01PKUhPuA45qM3rzWKZJql6FHS830Kq6CiMIU1d/GJnDmEHWvKAkS
         KVU56agSHGJlw46OMCv5uoEcoyQ74/+uXtXhJwtO9jNM4aHymzysW6EbUZ0A/3XhtA79
         IK/jiXqhvlbnwjA31Jd71aleo4nh429Oo5FdAcPArRwPW0cKCr8AfW8Xttela4NM06Uy
         MT3w==
X-Gm-Message-State: ACrzQf3NduTX1UGaR3gPxknkU8jSzlFgrpuzh8ZjIDTuYfmqwiwSgx7/
	YiWWHZQ/hrnskev4CEN6DZXDyz88tU4=
X-Google-Smtp-Source: AMsMyM7br8GcUemPnpVYuJNajmnpI6A7eedhCeFDkBH3roujQmM0+0gF9URAdniF5UY/morA7WGvtQ==
X-Received: by 2002:a17:902:e80b:b0:183:7463:f628 with SMTP id u11-20020a170902e80b00b001837463f628mr5826258plg.19.1665507305929;
        Tue, 11 Oct 2022 09:55:05 -0700 (PDT)
Received: from [192.168.254.15] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id a1-20020aa78e81000000b00561c55c56a7sm9587772pfr.94.2022.10.11.09.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:55:05 -0700 (PDT)
Message-ID: <7d77320c4fe03d9c5dc2d3a96b7a3def52d7e108.camel@gmail.com>
Subject: Re: [PATCH v3] client: handle wide chars for table rows
From: James Prestwood <prestwoj@gmail.com>
To: Pinghao Wu <xdavidwuph@gmail.com>, iwd@lists.linux.dev
Date: Tue, 11 Oct 2022 09:55:05 -0700
In-Reply-To: <20221011041108.5933-1-xdavidwuph@gmail.com>
References: <20221011041108.5933-1-xdavidwuph@gmail.com>
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

On Tue, 2022-10-11 at 12:11 +0800, Pinghao Wu wrote:
> Find out printing width of wide chars via wcwidth().
> ---
> v3:
>         Code simplification
>         Unify handling of color escape / char width a bit
> 
>  client/display.c | 30 +++++++++++++++++++++---------
>  client/main.c    |  3 +++
>  2 files changed, 24 insertions(+), 9 deletions(-)

Just a couple of style issues and error checks, otherwise looks good to
me. There are some compiler errors due to -Werror, make sure you
compile with this turned on. I use ./bootstrap-configure (may need --
disable-manual-pages if you don't have the packages).

```
client/display.c: In function 'next_line':
client/display.c:408:31: error: comparison of integer expressions of
different signedness: 'unsigned int' and 'int' [-Werror=sign-compare]
  408 |         while (i <= *max && i != s_len) {
      |                               ^~
client/display.c:420:25: error: ISO C90 forbids mixed declarations and
code [-Werror=declaration-after-statement]
  420 |                         wchar_t w;
      |                         ^~~~~~~
cc1: all warnings being treated as errors
make[1]: *** [Makefile:2409: client/display.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1588: all] Error 2

> 
> diff --git a/client/display.c b/client/display.c
> index b729ad4c..5ec80789 100644
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
> @@ -398,21 +399,32 @@ static unsigned int color_end(char *s)
>   */
>  static char* next_line(char *s, unsigned int *max, char **color_out)
>  {
> -       unsigned int i;
> +       unsigned int i = 0;
>         int last_space = -1;
>         int last_color = -1;
> +       int s_len = strlen(s);

This should be unsigned int

>  
>         /* Find the last space before 'max', as well as any color */
> -       for (i = 0; i <= *max && s[i] != '\0'; i++) {
> -               if (s[i] == ' ')
> -                       last_space = i;
> -               else if (s[i] == 0x1b) {
> +       while (i <= *max && i != s_len) {
> +               int sequence_len;
> +               int sequence_columns;
> +
> +               if (s[i] == 0x1b) {
> +                       sequence_len = color_end(s + i);
>                         /* color escape won't count for column width
> */
> -                       *max += color_end(s + i);
> +                       sequence_columns = 0;
>                         last_color = i;
> -               /* Add width for non-codepoint UTF-8 bytes */
> -               } else if (((uint8_t)s[i] >> 6) == 2)
> -                       *max += 1;
> +               } else {
> +                       if (s[i] == ' ')
> +                               last_space = i;
> +                       wchar_t w;

Move this declaration up with sequence_len/sequence_columns

> +                       sequence_len = l_utf8_get_codepoint(&s[i],
> s_len - i, &w);

Probably should check the return here and treat as a single
byte/character if this fails. In reality this should never happen (utf8
is validated on the IWD side) but just to be safe...

This line also exceeds 80 characters.

> +                       sequence_columns = wcwidth(w);
> +               }
> +
> +               /* Compensate max bytes */
> +               *max += sequence_len - sequence_columns;
> +               i += sequence_len;
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


