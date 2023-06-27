Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7670A47
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 02:50:26 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6b2c3ec38f0so2383504a34.1
        for <iwd@lists.linux.dev>; Mon, 26 Jun 2023 19:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687834225; x=1690426225;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BIiMIImxyQ7uBg5IJp4Saw1SczpbMNj9s3Y0Aik6Va8=;
        b=AFyJ4pSjPDVN2fU75QQxTtzFyWBgUgT3lljQiPZ46HfkrLPBt94jnD0DvP2CaOUHhv
         pGrkIgXIvYgtdAuo/8HXx5W7b/SEZtH1D+xCqMQMqc4YhtBGL5BdVkr2n1S39UpMNej/
         aCxjq8KaRr1JBoWMTH0y1oHFZboz+iJBaluCZWwiDCE77HJWwTS2Q1P4jTc/MJjI2JnF
         qv0B2Ugx1P9m17L1aHs1yjFZ+2aT8+ATNq1p+Zgs2kNh7OdXRlI18e7YBA+z6jkGSG94
         rkiNgxGeHRziaTYw+S9g5dZgyvG/bPmNQMJzQCGbUQvVER166PElvpQvkfFfxMsZ8tH3
         DLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687834225; x=1690426225;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIiMIImxyQ7uBg5IJp4Saw1SczpbMNj9s3Y0Aik6Va8=;
        b=RxysaiJi5SW7SkKZm+TlsBKaLWBg5rZ+8VnznaRvlLcHdVoaYxSL6AbBxmWXul+GkB
         lG0+LsWye0g3xjBVvlAMq0Z9cp+8MR3CIfLzwKy4C2F6CJWm/6UaIBEbpF9MX1m5N2bc
         lnbEvfgU2c/FVph1NgaGGcXP2X/VHu1F2YmRBerYfyUkZvTU4jxNo78wUJcOOTR1+x1l
         V3f4L4dZMrvE+cJ96dI4FrihgQvJYeAGajvpzbjyyP/cYZpCpft1YbHyQpCItlZHyHtk
         bhAcRWERENBCNcspWPQupnSB2YTlT9++zvbMvzL/vN4Ds/jffZqaFFkHpIgRfsVSMlNo
         DjLg==
X-Gm-Message-State: AC+VfDzMSSQWyCk0qVyh3ZT7/CZI/3jSASezAk+fjPgfvkha6UdB3WMF
	3xftAwrHUeNZnL7BQOjRMCfYBd7Xv3I=
X-Google-Smtp-Source: ACHHUZ6ft/s/ZDlBl8jefZTF4/GDmzDwmQnnJeCavFyaRmZMOLx2KMzuETxhdmxq6aYTA1bX7RkEvA==
X-Received: by 2002:a05:6808:20a1:b0:3a1:f135:6a49 with SMTP id s33-20020a05680820a100b003a1f1356a49mr1152661oiw.29.1687834225608;
        Mon, 26 Jun 2023 19:50:25 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e19-20020a05680809b300b003a05636f4a8sm3157390oig.29.2023.06.26.19.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 19:50:25 -0700 (PDT)
Message-ID: <d76401a6-1d34-674c-a9cf-848c9138dfe9@gmail.com>
Date: Mon, 26 Jun 2023 21:32:07 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ft: add debug prints for FT-over-DS
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230621193633.898045-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230621193633.898045-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/21/23 14:36, James Prestwood wrote:
> This is consistent with the over-Air path, and makes it clear when
> reading the logs if over-DS was used, if there was a response frame,
> and if the frame failed to parse in some way.
> ---
>   src/ft.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

