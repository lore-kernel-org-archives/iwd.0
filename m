Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182E3222
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 14:51:45 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id h125so21607927oif.8
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=GIAu/4UG2dB1u7sfBNND7OhltEnXF5YFITXvelGYjP0=;
        b=hCROtc034/KaUIvYdgCymxEZNq9MmVJFNkmhRJtlrjMWhomKAjidUCMBJDpv9BxZkb
         wT9EN1vYHaBCve/G6RoTk37amBUEkX0OWLZyVCFrJx76yoykU61lXgt6v72i6/xvSV46
         FfGg/QbdWA7bKiHWdhSNVRKd5z0+UCgifBfeqAydFW/bFYWgo6qzuEPBtCDfxa+0CBXi
         qygPSnTPaFPq1k+lYv4rsDlafqdCPzlVJDI5JJze6Gmy0S9vce/a2kyuAqO8gehXoXxt
         lvx6l4SoLxNQkpqJA9Kav6LVw4BYMvgNDKzDxsfQb59uwqoD80Xo2bwOm1eoxVKxOQ5P
         Z66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GIAu/4UG2dB1u7sfBNND7OhltEnXF5YFITXvelGYjP0=;
        b=oNP2gIgZM9Au4OphYcMVQN5jr+3eP9IwQtVJzH8EKDExtX4r/hfZptMWR2pWIheT2Y
         RZlTCRRX9JT2o5VgIz8q2COmaicTpAVc8VmBGsI83YNqmdMUHnelJp08L+q4OlrbshmQ
         mws3tmfqXNpa+twFvu3CyB4YAb+vWQdu3MUfbKjQmhw9FzKbjrRMWjp0wxyg5ETeFQLN
         S7v0zt0CUSW9K/NKUzKpY4YrcG2z6GJuPMg7CRq3wG4IErPM2jWWweGQuuYT07MHcAwo
         8zvSIEZTkxoiwrggZq3B1WVkzU57sD0ZjkKn00CmQAo5r8YHPuJL/5hP7FyuwDC0UKgO
         Jfmg==
X-Gm-Message-State: ACgBeo0881Sq8AF35Cq+wuSE4yePl9CLS3JUvOLUCsf/u2RGizK11hgt
	GFpVWHMn5JoXwX5+kbyhLIzKHLiSh2I=
X-Google-Smtp-Source: AA6agR5yiIENo6JLGtUTZU7dFRqn072BIMbl+t//wj+kbE9W4opo3rtNM7lyXx4im8GWjyWOwoWMJw==
X-Received: by 2002:a05:6808:3096:b0:342:ff93:4672 with SMTP id bl22-20020a056808309600b00342ff934672mr3877001oib.174.1660229505102;
        Thu, 11 Aug 2022 07:51:45 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y133-20020a4a458b000000b0042313f42b26sm1123440ooa.39.2022.08.11.07.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:51:44 -0700 (PDT)
Message-ID: <a72791b8-c60a-2a72-3c40-34a56db6d7eb@gmail.com>
Date: Thu, 11 Aug 2022 09:46:05 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/8] client: add STATION_DEBUG_INTERFACE definition
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220810231621.372514-1-prestwoj@gmail.com>
 <20220810231621.372514-6-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220810231621.372514-6-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/10/22 18:16, James Prestwood wrote:
> ---
>   client/dbus-proxy.h | 1 +
>   1 file changed, 1 insertion(+)
> 

Applied, thanks.

Regards,
-Denis

