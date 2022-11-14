Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CBF79C9
	for <iwd@lists.linux.dev>; Mon, 14 Nov 2022 17:09:04 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id n186so12039338oih.7
        for <iwd@lists.linux.dev>; Mon, 14 Nov 2022 09:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKbVaM7mkNU1iTtNJhuVrqx1G3lKfdMoMWHkuffAp48=;
        b=UCkEby3AOTPdd+uU1Qhgfbv3Gt24+sfLNXcbcvhp5VFZkdsAwbWDb89Jxv7x4Hc89f
         g+JLuVZI1mAlLAF7wq42bzDaoLBI4vUBap0NuDgPD/ZPtUvE1VQ3D7sYnYHAxz0RABtB
         fAYxTfVkwXF5DixgLbZYEmwoyuDO3G7IggtIfbN6PlExHFZGgSv2aiCsmBPRDYKmzaC6
         rOm4xss7XfDoil+eB540TVNYYqcPDTKLD/rgNeMxysMZDRnLqH9BQQjxQVf5n7OuWQC8
         ncGdf4ZrPErJ/u5cT19Mq8UXiBmnaoQ4EEERi17cCag+5qxB7l3RLQAtlnFrATo6i5f6
         A+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKbVaM7mkNU1iTtNJhuVrqx1G3lKfdMoMWHkuffAp48=;
        b=KG36UhpnoFdOaU1yviH9PUejwcFR7eTTtG5Unv2Po6vW4/0Hy4xrJxfX9wVOj/ZSvK
         dmq2/OftcJTX4e9MW+mca5LrWGjNEahJ2YgQW9J4t6cbVjZ2uitYqXnsz3YfQlW1BGx+
         Hp+zlKUX0MpaD0bE1RQ4EJ/FiozuhHmLcIQs4H6sf5vDnYz04dekaz3mrAAhzFdj8kN7
         D/SD+JM8xqMjD9xcsJmhRSDm8SWLw3vc8cIiy+M0h7lOxLRM5xIHxMCajj1zkE4JdRzI
         cmJmKOuLig59Yjo0ZAmErALZ5WLImyXcEvY4KTSWFjJ/ExLK+nw8F3KCsvCjfKPlaEOq
         xkjQ==
X-Gm-Message-State: ANoB5pmMJ4wWDXfqabL6q2JhKOOAZ+1U0VphR1+tI6pcZo4YK1iJGozD
	noW9yuBRdpSwcxN/7d04B44C02pZV3I=
X-Google-Smtp-Source: AA0mqf4nNqqmvya7bNZR5veJPgTI2NSpvUhrJA37WprYKlvEXglU6//DlZgZQ3L+6Cte7/wQ60zByw==
X-Received: by 2002:a54:4783:0:b0:359:fcf4:9e47 with SMTP id o3-20020a544783000000b00359fcf49e47mr6162352oic.81.1668445743085;
        Mon, 14 Nov 2022 09:09:03 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g37-20020a9d2da8000000b0066cacb8343bsm4389815otb.41.2022.11.14.09.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 09:09:01 -0800 (PST)
Message-ID: <b4119654-1370-4230-0b4f-75bb109eadf6@gmail.com>
Date: Mon, 14 Nov 2022 11:09:00 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scan: Add support for separate 6Ghz band modifier
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>, iwd@lists.linux.dev
References: <20221113140735.2325-1-marcel@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221113140735.2325-1-marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 11/13/22 08:07, Marcel Holtmann wrote:
> ---
>   src/iwd.config.rst |  7 +++++++
>   src/scan.c         | 13 +++++++++++--
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

