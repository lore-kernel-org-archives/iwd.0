Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DE72596
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 19:28:59 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-10be0d7476aso19710856fac.2
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=jzpnUZCCeWDegEvi1tr0lGm6Eywl3UBO6JgSk/ymqCk=;
        b=VG1FEES7gFowK0FarUpfUJb92OGn7bmH5q1nfW0tOtJecb5moGyJm3pYix7Ek4lZZ0
         hBg6dcemefGR9FQEWe/Pz6BXU7RobTKIVu0wBAwQi3vIuKR/EfFi6Q/2RTdnWru+cjlA
         c83Lp/YL/PqY5PWGYXc4kKfqAa3TmHVQbiMYwEpZhw7oFC6+UEX6vqItyYOt3zJ30edh
         DoTc9OEHWyPNGc3XxJ4IGtbOO+nlz0wZlOcXbVBvzUbWtWD6E57/cKHfl+Sjd0+iuyS9
         T0ulwQJVJdXWyjt9W+JhQC428GY4nxADjwavBDdqUJXRCe48tJBYQRuQxjzC/M88qpqE
         cqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jzpnUZCCeWDegEvi1tr0lGm6Eywl3UBO6JgSk/ymqCk=;
        b=5FGLyicRmI9TLNG0mAf+9HGyzZ7Q0Cy04obt8fTG4lpc292CuOHvyWFUvK6WWz26F8
         meOecQMGg7CrGyeilOHaP8NFZlDAIagYyLb+EcW7s0HvnrxRsNiDshDlk/m0uJfBkvRo
         m1hZ+jOJB0FFURoFOaihFXnmZgSgyJHDWQxyzGiicrOJ5oeovKK64HCGbaF5tFuMgyeX
         N8XZ8bhgbeQw3hAVD+r1adiePBvPzfcMI+o5F5TPu2co4wonzUZYyMlHeKuTziBRWmkd
         DmKByeBC1K5mEaj1nPubq+A4xUaWC9gmWbYxvD5Rw9J/CGI+422fTkYbl5j2hUL8OGhA
         JuNw==
X-Gm-Message-State: AJIora9Bt7g6y7qdRjn6FO0JBQeHlGzXcwZxKypzMysyEyb/+IKF3H87
	yiUG6sJmFqN6xIckRXEfE/Q=
X-Google-Smtp-Source: AGRyM1u0ykmNBaK5rCXIhpJjs5y9yFht/jSfqpqQWIEuvmcNAgVfIZByDWJ2k2bufCU42h9bmPyUEg==
X-Received: by 2002:a05:6870:e613:b0:10b:8204:85e1 with SMTP id q19-20020a056870e61300b0010b820485e1mr3894663oag.65.1657222138943;
        Thu, 07 Jul 2022 12:28:58 -0700 (PDT)
Received: from [10.0.2.15] ([136.32.1.70])
        by smtp.googlemail.com with ESMTPSA id o7-20020a056871078700b000e686d1386dsm22872191oap.7.2022.07.07.12.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 12:28:58 -0700 (PDT)
Message-ID: <83fb9f3d-5e3a-68fe-c274-0c7af57b5843@gmail.com>
Date: Thu, 7 Jul 2022 14:09:53 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 01/14] client: add generic display function for table
 rows
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220707175511.224597-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220707175511.224597-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/7/22 12:54, James Prestwood wrote:
> There was no easy to use API for printing the contents of a table, and
> was left up to the caller to handle manually. This adds display_table_row
> which makes displaying tables much easier, including automatic support
> for line truncation and continuation on the next line.
> 
> Lines which are too long will be truncated and displayed on the next
> line while also taking into account any colored output. This works with any
> number of columns.
> 
> This removes the need for the module to play games with encoding newlines
> and tabs to make the output look nice.
> 
> As a start, this functionality was added to the command display.
> ---
>   client/display.c | 181 ++++++++++++++++++++++++++++++++++++++++++++++-
>   client/display.h |   1 +
>   2 files changed, 179 insertions(+), 3 deletions(-)
> 

<snip>

> +static bool entires_done(unsigned int num, struct table_entry *e)

I s/entires_done/entries_done

and applied the entire series, thanks.

Regards,
-Denis
