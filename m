Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E842F4A32
	for <iwd@lists.linux.dev>; Sun, 16 Apr 2023 18:14:53 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id ec6so8602203oib.8
        for <iwd@lists.linux.dev>; Sun, 16 Apr 2023 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681668893; x=1684260893;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pjzFuZKQthxsk/RSy9p8ZXdQiVZlJ5E6PMziSsoD57E=;
        b=F95+8acHu6hUMtnWrtgPws95+DCI3F85FJsOAyzaU6vtq59GKP4koRcDbQma2SE5xo
         QEsfRJ0jyUhPTqrH7slJO02yOlUwdDH+YMJAZrPcIRUVs6pJSho2hXDZA2X7+QIhxLoi
         0dznOXT1y1s3PUS1/4Yz65IiKITlSHJgdatHMIfKR0NuwWU9h0jMdKq+yZn8xekAVVSw
         +TwvWoXlhJV3IGaUgFGstHMnDdqRd8mz2HrWn0sMxzZXz8/N3WfRcb0HBIpFaRsT72bW
         270+hsQUQEM0QwycZpgjPEpsrWtmh6LsrFajKiygykBGDQACqGJnRmp05WZY/hb1HhiU
         OHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681668893; x=1684260893;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjzFuZKQthxsk/RSy9p8ZXdQiVZlJ5E6PMziSsoD57E=;
        b=dSoj8XJLYjjoped0vvstOzLI9WioGDBGPxr2aTIBEopMzw9nh3Hj37uW+a6KdpqDxa
         Q8XgmXkxy28YgLCGvCVq+AXA/oFqDfhihGgh+xsg3UKNv0W0DQsn09tv9ELPFwqAFIbc
         McF5+RjrsSk87qUIXHgLRDzsxSl1W+0ngl/NoxeaSY9VFs/DCdzlMT5p6WcF+lz47ewe
         jz2eSBCOW3QbLvMIGizI4Gd+d7H6k1odDkfDF0po+coJj8fg/J95sktLlpqdtoeG75Ae
         9K7EgrEorGQ24kXJrf9VTEs1LD6xTFI8umf8lm/GvRqVk4N6KfudtfmEEUkA5uS2e5jH
         IUxQ==
X-Gm-Message-State: AAQBX9ec1ady+R8gxn2om1q6G6Ah3llBWT+zBAVXypcB7DidW57QlIFH
	KtCMTDJGNS3Vo5tMrRPPCD5P1HaKKmNx3Q==
X-Google-Smtp-Source: AKy350bMBTDCmEfjOW5S47N8CtB4IZ5xZRluEPueZXyVd2Y159cyV+tbDmOXL5BztA91LPUFPtZcAQ==
X-Received: by 2002:a05:6808:4346:b0:386:c50a:c8fa with SMTP id dx6-20020a056808434600b00386c50ac8famr5373779oib.28.1681668893103;
        Sun, 16 Apr 2023 11:14:53 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y124-20020acae182000000b0038c35f512a2sm2965463oig.56.2023.04.16.11.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:14:52 -0700 (PDT)
Message-ID: <cace462f-5876-f7d8-6b36-9734a58c65d2@gmail.com>
Date: Sun, 16 Apr 2023 13:01:32 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/9] common: add FT-8021X-SHA384 to AKM_IS_8021X
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230410220135.373872-1-prestwoj@gmail.com>
 <20230410220135.373872-8-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230410220135.373872-8-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/10/23 17:01, James Prestwood wrote:
> Without this the AKM shows up as WEP.
> ---
>   src/common.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Applied, thanks.

Regards,
-Denis

