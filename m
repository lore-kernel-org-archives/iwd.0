Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1BAD23
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 19:54:51 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id d26-20020a05683018fa00b0066ab705617aso1241337otf.13
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 12:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nfu2YPLzNUMekkU7nW39o5MfARH7JcOAaSoVKPUhmQ=;
        b=HY36MSfmOcoKlg9mte2mYu6SGgBkZl9MKoRU4omUYPQz9sHI+Uu7FZBxiFEmdAuboQ
         Ej4c1ilDJBQvejReauE7j2u+TZgc2fGmcloNwzPv60hIJFc7NOw3/n0O20+/BoMM99nL
         aQeawk14CvfCnNhjcKw7BssyEbZhGGaiMhxSbgLoxUC0Mp7msksVOZdhKC6ydy2aagAL
         gkBqQsYHd6EqYhhAhdUZb58JSBgMP6vldY7XF44GDXwfu9lO0cyDCE0c/Pr9+/BZXmHx
         dYVxRPk+v7cmpfF36X2NlGKOpYlbkREdHvsB/hYimEZRkRNpc0XCM4yzhJUXsX2jH/Bu
         yUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nfu2YPLzNUMekkU7nW39o5MfARH7JcOAaSoVKPUhmQ=;
        b=YyWJzxvQct2TSjN0UMtGgrp5cbbIoyIcYAPgE42px8sfqSr+odRBWJk7ikz3l9ePQb
         sNOoLQVcKHT5g1QVY2+Dh1xTGxSS7mcV7yMJd0+S6vRmKCJ8XD96kZLkeCpcQ+irr9I+
         Xl1ksaLj23qYa6wVFY/irT98br8GJDF1uGu1zT6kTBoxEfXj14/2+Sr8yMIVqcDWAZKH
         3sQIKqi5dhsvzTKQLjP9eDREwZURrZPH9wdrj+1GD0EKy0f2oGcOwj6GE78cJa98ZyKx
         l5lBcdpYvb9rayjjNKERk+EUKQuyelrGeuYyVNa++4diORaAt0gmISxR8ljeqNKbzNUs
         u8EQ==
X-Gm-Message-State: ACrzQf3VGZ07Is3pN1iFdfTJ7Un45OKjxt8I3On+Hh4I0Nxd51u2lfFQ
	T09BgBFCcrust9E0/sJg5YDr9TJ1IhM=
X-Google-Smtp-Source: AMsMyM5hLfzb9QLnyeHRiCH4Z6lO5dcVFdE11jeVpKGkyxD3M97umsN0XZ2XCKmr56S6xeieuAZTEw==
X-Received: by 2002:a9d:30d8:0:b0:66b:3596:9639 with SMTP id r24-20020a9d30d8000000b0066b35969639mr535440otg.363.1666814090994;
        Wed, 26 Oct 2022 12:54:50 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k7-20020a4ae287000000b00480e1109695sm2538509oot.10.2022.10.26.12.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:54:50 -0700 (PDT)
Message-ID: <a91d629d-fc1c-f09e-51eb-406b3a9a005b@gmail.com>
Date: Wed, 26 Oct 2022 14:54:49 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] netconfig: Avoid generating events after netconfig_reset
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20221026175828.2435994-1-andrew.zaborowski@intel.com>
 <20221026175828.2435994-2-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221026175828.2435994-2-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 10/26/22 12:58, Andrew Zaborowski wrote:
> Similarly to l_netconfig track whether IWD's netconfig is active (from
> the moment of netconfig_configure() till netconfig_reset()) using a
> "started" flag and avoid handling or emitting any events after "started"
> is cleared.
> 
> This fixes an occasional issue with the Netconfig Agent backend where
> station would reset netconfig, netconfig would issue DBus calls to clear
> addresses and routes, station would go into DISCONNECTING, perhaps
> finish and go into DISCONNECTED and after a while the DBus calls would
> come back with an error which would cause a NETCONFIG_EVENT_FAILED
> causing station to call netdev_disconnct() for a second time and
> transition to and get stuck in DISCONNECTING.
> ---
>   src/netconfig-commit.c |  3 +++
>   src/netconfig.c        | 15 +++++++++++++++
>   src/netconfig.h        |  1 +
>   3 files changed, 19 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

