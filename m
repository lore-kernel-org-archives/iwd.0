Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ADD3D83
	for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 18:44:37 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-fe023ab520so400275fac.10
        for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 11:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=JUUerf6JK3YHvz43VRKPnnH2K97UhwI5oXiRahPmvx8=;
        b=KC7/i9SAqFVIgX0uV5OGm6wDSZZH2Nfj6343XprwsIdm3XsQlWldRPa9WaPEFFo72U
         nO3hOjmu+BgkIPFR65lApO/v8sIkyUH75WNQE4axE6gtDd/c9q/oE+u0+q/uPYIWtJxW
         Zdu+Ev2aChBdGOE8tjR3Nt++9VZhzA8FsrcVzm0vZnRK/SYkXsbnJZ3blxNdFUG4qUUJ
         qi6f/Q6CHlwlwU7qX8np4s3poItt/z9zATzjByvMzgkFX5s6m5M5WngNJUm1Erc2SuUf
         XTUEJcXuM0m4K2kQ+UItp9hQEbhL67QntXbWrx/cdDh/V0aWBk7zZxFc2e+qVVN57npD
         WUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JUUerf6JK3YHvz43VRKPnnH2K97UhwI5oXiRahPmvx8=;
        b=tUfP1lv3ge+XSt3IHGreh++GJk/Fd2fEIDGNmMXlRyOd+TMJNOWqTN+udwggqyNGAD
         asvkV8zawkCiRTb45JOrLSaSRF+ZCB1LdD4qVPWXNpKn8wscmPcvRKyUEOU8H8seENYB
         f0I3FB4RqAPNlCOymag5Lq/Pk6W5I4BG15CA4I6QTfHpd3nF+2bRQnm0s9uP44rlYwZM
         VdKZeLJ/+hamJtpRYWO0QikUZzj6O8UZ76OvTBGGH1CK2D3A9he7d2ENaKiGUrH8+sgd
         2TQcA78jP8R2Ei+0zwLUkwK49xgdkOkLa2j7GUj647ePRQSVu2U430GNPWow2Agq49k1
         M9/Q==
X-Gm-Message-State: AJIora9pIYmIloeNyTYxJnpvFqTAPH4XyodZ1bn0eWJgFTZtuWzTbKxZ
	Ipq3cYvx88RV+o7GYfC2ncQANEfyOe4NhfbM
X-Google-Smtp-Source: AGRyM1ud5Y8MeWIVkIRXqz0fDI/Drqfb3cyFV8w20rZvGvmEb8cHWomoJrjMawh67iZyyskyq/bybw==
X-Received: by 2002:a05:6870:c68a:b0:10b:95e3:3dd3 with SMTP id cv10-20020a056870c68a00b0010b95e33dd3mr4825813oab.248.1656614676941;
        Thu, 30 Jun 2022 11:44:36 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l26-20020a056830055a00b0061697cd25f3sm11427090otb.55.2022.06.30.11.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 11:44:36 -0700 (PDT)
Message-ID: <1a71e129-a9f2-6bc0-f791-e876e9db4d9d@gmail.com>
Date: Thu, 30 Jun 2022 13:38:20 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/7] auto-t: iwd.py: add DPP properties
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220630180331.206419-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220630180331.206419-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/30/22 13:03, James Prestwood wrote:
> ---
>   autotests/util/iwd.py | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 

all applied, thanks.

Regards,
-Denis

