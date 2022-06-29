Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A336AB4
	for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 20:08:50 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-101d96fe0a5so22944330fac.2
        for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 13:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Zg7ttPQRLM5k4CSJgslwTvlYZbk3S74oFPLqANZcnfA=;
        b=PijVT3ngmKHo3x33WF0plXrhpUw8ThIqRQP9cvrMwstMvwy9AxkE4R+HIYpsSUhnH4
         zFdZ+p7twLynkfODYf9c6UUU6UbafSS3JEEPtUkYRyqMDFrSFv/FwWDzS3JJdlfKqSNC
         aXY9JKrVtAN4154cEUwi7rlUVL3XQWWAlRMVGBpJ2a+INbU23ymY7WvUefPZoF4MgsfF
         nyeJdE5FKKjMEf7ZuNm8IsW49uoC4zdYq5Ch8T3iFqKKzShU5SXOwfd7t3j9v4uUmZXd
         Y7mTbHAnciqjZLjp15DoGrJswyp+h94LY5i/x4F5w/LeWfwokUyNO+P4k7+VqqzQXYZ4
         RFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zg7ttPQRLM5k4CSJgslwTvlYZbk3S74oFPLqANZcnfA=;
        b=T/9abV+5jx0juiA7kJH1C93Wo8xdJBx3r0mz9Hy4ZV2q0XMrRLYddrD3pl+zRKVATD
         9djF4klchmfnqXPbIJJk/MIvz5uXlKW949VpqEO2HZkqg0bbgUppFFQt5zmHZXsGP+DD
         U1YiXF78RmfpIUl37rANdDc+oyqrtCRufqQ0k+7LirAitAPTWFIkH7VIqdWQoMKfmTkG
         UbmsnUAdpzw64pYi+K6qPzN+2FPYcVlGWv5v1GToUCGmhJQfbqbLIp0CnnFJS4pNE6LX
         9odwopkKHJ76PNJgtAk4syAU94/9d1/Wbaak8AqFP5JO/Cj11kIeGG3OWFcARkghZSo9
         G5Bw==
X-Gm-Message-State: AJIora/UOdHpH/QUY9PS+3+Tf9rOvxPYhaL0wOEW6i124KlTVEFIkLDL
	aBNq1GXoWo5ZIoHeq6rWoBU=
X-Google-Smtp-Source: AGRyM1sDsSRSwCRRLuQiVYo5TNaIBGulKPXNyI3HXBbPtg7j6DEePZiIBOlYULpAOKU1tCs+EAU/bA==
X-Received: by 2002:a05:6870:f287:b0:109:d5fb:15be with SMTP id u7-20020a056870f28700b00109d5fb15bemr2982814oap.12.1656533330020;
        Wed, 29 Jun 2022 13:08:50 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z23-20020a4ad1b7000000b0035eb4e5a6b6sm9736305oor.12.2022.06.29.13.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 13:08:49 -0700 (PDT)
Message-ID: <f08faaf0-3c29-0acf-d95a-cb57d82cfccd@gmail.com>
Date: Wed, 29 Jun 2022 14:48:42 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] client: support multi-line print for long values
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220629192709.38743-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220629192709.38743-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/29/22 14:27, James Prestwood wrote:
> The generic proxy property display was limited to a width for names/value
> which makes the output look nice and uniform, but will cut off any values
> which are longer than this limit.
> 
> This patch adds some logic to detect this, and continue displaying the
> value on the next line.
> 
> The width arguments were also updated to be unsigned, which allows checking
> the length without a cast.
> ---
>   client/dbus-proxy.c | 21 +++++++++++++++++++--
>   client/dbus-proxy.h |  3 ++-
>   2 files changed, 21 insertions(+), 3 deletions(-)
> 

Both applied, thanks.

Regards,
-Denis

