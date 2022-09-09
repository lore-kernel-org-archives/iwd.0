Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD034A02
	for <iwd@lists.linux.dev>; Fri,  9 Sep 2022 14:15:44 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1279948d93dso4168481fac.10
        for <iwd@lists.linux.dev>; Fri, 09 Sep 2022 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cZujs1XNR1ZckNwKxFZlUvtJe3XOftQ1Q/ifWYQE4e8=;
        b=NN8KtncRWwKXCQv6VYAI88HjlcdWC5W9aNdb0McTgGpG0I08JT7uBYe2DdMi0wUuc+
         3KYidnlwETWe86NYWgIXnOKCyW3aZxG5KyoV9laoDNB4nqYyc3Cgew2kHNkXAcgfmTxO
         C+yFPFjT4qU/IFX2jmlw+mVVajMnagI7muR+k4GdaUdZFffn7RHBAVm23nN8MFcmktx3
         iD6l0tuiigljzfLHwpugLAXwK7IoEBzoONwkRW/PchvSkwfNX7JfacDh36h3/+sXkZ7Z
         MirmvBrsxwLbs8z+ANFctJmIWdX2JTwRiYaKtWmQwnuZtabtRUHlj5HdY87udikipLBu
         E2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cZujs1XNR1ZckNwKxFZlUvtJe3XOftQ1Q/ifWYQE4e8=;
        b=vT29sR5vdapm6RVlUbisJhY3/5R4LtzQeQFEZ6kjZr4M4SuGD2FDbMyO41cjYev1+i
         A81PmKcmmyTl8Tg9YzbykGdFHrNd0+i1W563cz1nJ8wWpQ1wLFCR7Zhtqd8aVCrVDhnj
         2nkOHlrEL1BaVQsGyP8ynEdRWV4BL+i9gj6fZTDbVRDOY78WM1nHxTW0crPzNn2Yu1gQ
         9DGqRX3NOei/wOeBK0Cjjry4j58FuPWU+wsCK1fsi8p/TLPePsIqkDnfpMoZQgblUy+y
         nvqJvoj1JBfAPD8uFjWunR7KqhcHr+AMwIm6TGClL/BkAlEZOPx/0n9bNPDGwFhMJa6q
         /kuw==
X-Gm-Message-State: ACgBeo2EZZuE40hZQxcQUm51HLKr4LqeGiHLPnx7ouvrqy3ry/f8HGHw
	9ye/Eqd5raIDqK8Ho6ienQY=
X-Google-Smtp-Source: AA6agR6Fnlb/6VEdfs5aJl/IyPCSigtcaPoi/C5yB2fvsD0d+SNJD6kUu3v5lDlicTpSNulAcWNdvQ==
X-Received: by 2002:a05:6808:2d8:b0:34d:864f:8188 with SMTP id a24-20020a05680802d800b0034d864f8188mr2647650oid.295.1662732943879;
        Fri, 09 Sep 2022 07:15:43 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k25-20020a056830169900b00636e6dea5e5sm328734otr.23.2022.09.09.07.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 07:15:43 -0700 (PDT)
Message-ID: <5da8112c-4f65-eccf-86c0-0ee4f40b74bf@gmail.com>
Date: Fri, 9 Sep 2022 09:13:34 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] doc: document [General].Country main.conf option
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220908230639.440880-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220908230639.440880-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/8/22 18:06, James Prestwood wrote:
> This lets the user set a country code explicitly.
> ---
>   src/iwd.config.rst | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 

Both applied, thanks.

Regards,
-Denis

