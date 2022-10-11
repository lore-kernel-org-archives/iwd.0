Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770CA3D7A
	for <iwd@lists.linux.dev>; Tue, 11 Oct 2022 19:31:51 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so10749278oop.9
        for <iwd@lists.linux.dev>; Tue, 11 Oct 2022 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8VfLaK/Sg/caukkgIVw98EVN45gTgSv5WgC4h2clhss=;
        b=H5sueKTPqF58foqfFsMmBYwAT33wZxMkA4WgZ5OrRLxaU61/GDOjMHm4Rldgb3A34/
         c+d0MCLfiQkd3AvranZUavvttB5WLAdXPFrsERuBwmmmiOD77t37vkr8CVYRzkq1/rtm
         +QpFav0UEfsJrSpfUbtxov2uS3PqaHix5e4RK0NcF0mBdkiyK8kLAtS9/Tea5PlVB7Of
         j00TL8s3ztdte2jEGYoKLaQS9ofXM5/0AO1HtJmGdc3UGJY858tlXXoR+Z0W7/DAgJk+
         b8oYAP4hkspueXhFEYWyZeZzxwlU8sgSnvj+JvQh6ml7R8xB2sBeBGM+c2BJ5S63ONnr
         rdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VfLaK/Sg/caukkgIVw98EVN45gTgSv5WgC4h2clhss=;
        b=0068tEgcIWpPqot69PDj1wklmNwk5xLeuT1ZaxgaeoxHnbeYaxeL6xtWy0YKNA4kEc
         Eag9GNQLr6e9ifDdJcKLAhAEz+KbLFFWePxe0wA1pcPL4CNq4PxkHgozGE4wmtdt0XJc
         tswFYkgfSE0p3PA8zDhH72fXDdjEfOWFwEdbxrkybr6Pq5tzJFOeVWFwGdKd21aVb7kY
         V0NDTS+86ccILncjVetTlFjLe/KI2jcyBR7kUKOCvsFqYQ0RLiZA6pt7rRBBWblrcrg0
         dUkICvMEacUoIaHgWpxzQZ5PJn9nA5KuFVVSfjdY9+1o7+4L/dcTcq0InGvXBVmoFKuk
         Kq3w==
X-Gm-Message-State: ACrzQf28+T7MNvJ3N6+v+i4zCtMajUpliLPZWJgn9N7T+qbNKOXmsLwX
	iDoqcOmOKcZTjVwcO2obN4FNerpADqE=
X-Google-Smtp-Source: AMsMyM7izlDsqQMCHG29xTKh0QxKkaOy7Aq57kmtO7Vsf2RKxIEABUYwoxNQiPxZ7g2xzzFS2L5UDw==
X-Received: by 2002:a05:6830:349a:b0:661:a1c8:af78 with SMTP id c26-20020a056830349a00b00661a1c8af78mr4392402otu.331.1665516710484;
        Tue, 11 Oct 2022 12:31:50 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v24-20020a9d4e98000000b00661a0a256ffsm2368568otk.81.2022.10.11.12.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 12:31:49 -0700 (PDT)
Message-ID: <92b259b5-f26c-6fa7-1bca-1c4ed584cd3b@gmail.com>
Date: Tue, 11 Oct 2022 14:31:48 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] station: skip disabled frequencies in neighbor report
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221010194011.55962-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221010194011.55962-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/10/22 14:40, James Prestwood wrote:
> Use the disabled frequency list to check if the neighbor report is
> including a frequency which IWD cannot use.
> ---
>   src/station.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 

Both applied, thanks.

Regards,
-Denis

