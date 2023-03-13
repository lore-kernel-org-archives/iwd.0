Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22F23A7
	for <iwd@lists.linux.dev>; Mon, 13 Mar 2023 10:08:10 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id cy23so46242178edb.12
        for <iwd@lists.linux.dev>; Mon, 13 Mar 2023 03:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678702088;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxnsuEwSzNDRh6Br91niI6q6z1qj3RdUSoH38pUgYDs=;
        b=FC3XuzaYNSEvjEN7LlgANKPXgAX3gTuRvkViFQ90IYYRzbBB/zi7w1dRJb+UpEmM0D
         ek0o2+Eo6puN3FDqKBgiaL/xludf69AiAIozzujfsienEJsezfBHGsGZKsF1LcLYqr8w
         eQRLcq3Pl7MqpXmm1zvWx9ELS94l3FYYJVw0+vlYqvMENojWGXjuNTzstj2bLw4pkGtQ
         ph3QYmdZGI9YsFLzVvAZ8aBMlq8uofqIlSIvKrSSlf1xvOoXvu0RgSvX+Dr7sgF6mDYx
         hLEiC1NSybE/Jq6dvJAU2PLYtDDtrM5AHeWzUsRElFnEzykTZtHtCECCnxSlwOeRWlpO
         33WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678702088;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxnsuEwSzNDRh6Br91niI6q6z1qj3RdUSoH38pUgYDs=;
        b=ZsPSD4BXFsiyZVBuxX8L2+bpDt5WUmjRQ+lCHwjpRxJUEMXzJUYN+/j/iOMay9w+kc
         GKm8SG1ekU5i6X0c3Gk6SHAIy57ydqN5lZDNsiyUgHNYZdDvObAa8FUHaC1rLm4s4wGE
         UE2BVDBXNp5jmFI3YGp/mcNQA7HuiaW5wVcD8ix/xWcm2NKPatGd/SiFz56csL0FmT6G
         NiU15Ep/YycTBduofilF0HFf0E8EDvQkqqSV8zrkEoRjF0zJtBRhI9rts2r4fh0IGYsI
         vmQMNq0/N3HGWQcKJxAtNniIV483CLQ1xYFgQ9AIgRnUTMjMiAc3LYJefHUHn/TDL7f+
         7GRw==
X-Gm-Message-State: AO0yUKUMv0yNONGfzEdKYyE+z7JsDCtZiwKz6c6D40YhGb6BQxB3Ukjc
	PCz1lomLcG/xIytPGdSfz8XGXV3I25X8qxHCEeSKOxamLW4=
X-Google-Smtp-Source: AK7set9KJUVrgkk/GqNYIZrZ8vPNP077Jh4xbfE5L/VaQP+FTTNWTNaJu3EKwfEWNhvfe9TBrtSspgU/qQJef1OL4TU=
X-Received: by 2002:a50:a6c8:0:b0:4fa:71a2:982b with SMTP id
 f8-20020a50a6c8000000b004fa71a2982bmr3205204edc.0.1678702088108; Mon, 13 Mar
 2023 03:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH4auOnuK_dDemZRF4BMq3LPL6A5cmLfSgJKeFVKAYZUNGAk2w@mail.gmail.com>
In-Reply-To: <CAH4auOnuK_dDemZRF4BMq3LPL6A5cmLfSgJKeFVKAYZUNGAk2w@mail.gmail.com>
From: Alagu Sankar <alagusankar@gmail.com>
Date: Mon, 13 Mar 2023 15:37:57 +0530
Message-ID: <CAH4auOnsUMnrBbfCPOh=vyvk2DnESz1YtDdpcD9fe_vzw3vbFg@mail.gmail.com>
Subject: Re: 40MHz Bandwidth in AP mode
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

We are testing the iwd-2.3 version in AP mode for one of our
requirements.  When trying to configure the AP mode in Channel 36, it
was always selecting 20MHz.  The band_freq_to_ht_chandef() function is
supposed to select the best bandwidth. As we see, channel 36 is
configured as 40Mhz capable (operating_class 116).  Debugging this
further, we see that 40MHz spacing is rejected due to the following
condition
if (info->flags & PRIMARY_CHANNEL_UPPER && attr->no_ht40_plus)
    continue;
if (info->flags & PRIMARY_CHANNEL_LOWER && attr->no_ht40_minus)
    continue;
Channel 36 is configured as PRIMARY_CHANNEL_LOWER and the NL80211
attribute is indicating no_ht40_minus for this, but as per the
condition above, this is skipped. The check above seems incorrect.
Can you please let me know if 40MHz bandwidth is tested on AP mode?

Best Regards,
Alagu Sankar
