Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607DB66E8
	for <iwd@lists.linux.dev>; Tue, 23 Aug 2022 20:51:21 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id v125so17463663oie.0
        for <iwd@lists.linux.dev>; Tue, 23 Aug 2022 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=FbDBcFt5yAqD2eGvAP1CNFhgNytiokrCg2hBdWY1zJA=;
        b=Jjb830JlVHcT58uh6y57hEWKojIHX+EPTwDyxXLI7Qe3wcUEmCV1iRMZdFjPrRZWQ3
         Q6tBRi5psnAJX/8F8yzLbdQL5qZ+UkhLcvXxpSyJskV4LCsxXPwsp/5ZGckQ6TwVJMZD
         DRieqLkmFMz1uEEO8W4U5b6PxIwCCVL8dRCuhs8++yQ67evpHvr1g6nhm+/vc6v4MoXh
         OkO7xQkEvQA/oD5TzfEXYo/CG9OBfnDOVFp0SbGGlO8IVmI78MJf6IsmPKCeqtNMQceX
         sRpTZqhy1uVE/IBHjb1lU0aFumr41E986P7RV9Vfhm2pgGToVQdWy7CKNh1JKPNtDXBH
         Wx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=FbDBcFt5yAqD2eGvAP1CNFhgNytiokrCg2hBdWY1zJA=;
        b=xaA/eSSYHyLYlzjVsmY0kFqzEZAOo73CXiEwORuqcjuQhDyxFRZpKWIOp+ihVxx4Lr
         2BxbRyw381zCFH3qgjnqbQx8RxDyoPnUlG7BjL3fu3TuUqQvvSPDIWB78O0vO0m+W853
         f7uh6ZvHE37gtkP9YrStobc2KgXyqvEJ3NE+w7H2OP7Xz86iLepAV/mYQqvvQY4YOCJk
         68ZO6KHDWpkCl/PmfEMSByVvf2AuHnq/7tYejSwBY3z9litMGC1fcaRImDOXb9DrpIuy
         mz5avhHtKPl6ZG+mO3AMI0AIliFF/2eKl6JYbQ8Df1mDTf7JhD5BQKN45jbKp9Xi3K3T
         HPYQ==
X-Gm-Message-State: ACgBeo1xDIGvZK/41HiaMuebbUjbXHxyrfoZYcXTKB8va1wRDsvTnchX
	gXoAblhvDyNpFaPY/p98N3U=
X-Google-Smtp-Source: AA6agR6FAqWoCIkKXMFkn12+VZ/ba2JrKqC13lFTQ/cA8RxzQtjGZFsnlf5+dCysYSX4/o5QeLQvOA==
X-Received: by 2002:a54:4412:0:b0:343:50f0:4899 with SMTP id k18-20020a544412000000b0034350f04899mr2007251oiw.72.1661287880341;
        Tue, 23 Aug 2022 13:51:20 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id m37-20020a05687088a500b0010efb044e37sm4073449oam.27.2022.08.23.13.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 13:51:20 -0700 (PDT)
Message-ID: <29bbb0a6-424b-2c1c-4269-0075dfdf51f1@gmail.com>
Date: Tue, 23 Aug 2022 15:47:23 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] autotests: Fix testNetconfig ACD test
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220823163616.1466543-1-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220823163616.1466543-1-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 8/23/22 11:36, Andrew Zaborowski wrote:
> Part of static_test.py starts a second IWD instance and tries to make
> it connect to the AP with the same IP address as the first IWD instance
> which is already connected, to produce an IP conflict.  For this, the
> second instance uses DHCP and the test expects the DHCP server to offer
> the address 192.168.1.10 to it.  However in the current setup the DHCP
> server manages to detect that 192.168.1.10 is in use and offers .11
> instead.  Break the DHCP server's conflict detection by disabling ICMP
> ping replies in order to fix the test.
> 
> Previously this has worked because the AP's and the DHCP server's
> network interface is in the same network namespace as the first IWD
> instance's network interface meaning that pings between the two
> interfaces shouldn't work (a known Linux kernel routing quirk...).
> I am not sure why those pings currently do work but take no chances and
> disable ICMP pings.
> ---
>   autotests/testNetconfig/static_test.py | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

