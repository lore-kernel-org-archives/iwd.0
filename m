Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11097C
	for <iwd@lists.linux.dev>; Thu, 13 Jul 2023 02:34:01 +0000 (UTC)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-345df4e68afso786625ab.0
        for <iwd@lists.linux.dev>; Wed, 12 Jul 2023 19:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689215640; x=1691807640;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/896znoJ3xGLTa0SHPxeNjt524arHfM+aiCDDDxQBQ=;
        b=cqCF/iObTNbHFupvJ1SKEJLU8yoK8QJ8kEJvLAeNuYkTRkMMQyOpg1d9webJY5JTpd
         WD/dLAplSzmdZ2e6P0DxNmj0FjiFPD2DMh0lCYVfUYX5HYZYSmjTVp1wrCujjDsUdVLN
         X4G/dHNDl1Uls9JdaEHwc5RQ8R7sr6zA6c9nU9tutB8YaZjcR69au3L3+H+J6mdpC3zX
         wkjjm+Bfii8I7frbDm1MLGRPKpqCzcd5edRHfJ9sySu0SrN1nJ7/pqsgljgacFrbzf75
         U5cHtNti5IiR+pvT1aYZ+uHD4rhHRXvxKSNNtL2WvA8qBDKTN5SGr8dl6xQvZK9Egh2/
         GHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689215640; x=1691807640;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/896znoJ3xGLTa0SHPxeNjt524arHfM+aiCDDDxQBQ=;
        b=WQ+/UDWf8MO5szIV42IUKWMsvX3hbeEJnrOgX4QF2wHHW9DIND2kOZEBdXL/tXFMd3
         7iL56Cra+nnZGMygIMA/IK9U8cVcNqRcjnZbmehBIR8Q61SlBc76EkHBLzs3a52Ftnbl
         5hTdAaGpNXxNWt8bZGloI77yoQGBep1uIXfEChlCGJM24PLI28Za88Azhrl0QoyJQeMZ
         15Ou24h+OzwOGq/E8BnxyfWm5CWVoTT6v36obszvoW5O8V50FMb2LFmu+X9K6cob5nOD
         /WoxD67QOXkTUZjARXCPORWDKvamiUutEp/XXJULJ/DWSozyGbMlZ9TeDRmlnLOKP59y
         dsTA==
X-Gm-Message-State: ABy/qLbEdF4vi8he9wmw5wuw20qsVcQ5kfX6JPVU2cO55x3XHGmYYKIj
	V97nBWOG1i9W/G3tcXf1d+I=
X-Google-Smtp-Source: APBJJlH9tCdwCpEK6j+I5qYWsp6RLHbt73k2SpqkCABJO3LdRZtYwkUYUbOgcsXzLaorQiWlDQvDVA==
X-Received: by 2002:a05:6e02:216c:b0:345:dd32:c61 with SMTP id s12-20020a056e02216c00b00345dd320c61mr252120ilv.32.1689215640501;
        Wed, 12 Jul 2023 19:34:00 -0700 (PDT)
Received: from [192.168.254.37] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001b9e0918b0asm4652311pls.169.2023.07.12.19.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 19:34:00 -0700 (PDT)
Message-ID: <d2a490cf-ae06-ed26-33eb-5475616bd725@gmail.com>
Date: Wed, 12 Jul 2023 19:33:59 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/3] owe: netdev: refactor to remove OWE as an
 auth-proto
Content-Language: en-US
To: Wen Gong <quic_wgong@quicinc.com>, iwd@lists.01.org, iwd@lists.linux.dev
References: <20210903193544.13897-3-prestwoj@gmail.com>
 <a7e76f73-da60-57fd-6686-b26e5c342d87@quicinc.com>
 <411c867b-f830-c66c-4c21-f59200993b2a@gmail.com>
 <00246aa8-fe45-f5c2-cf2a-3450cee414f2@quicinc.com>
Cc: Denis Kenzior <denkenz@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <00246aa8-fe45-f5c2-cf2a-3450cee414f2@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Wen,

On 7/12/23 7:23 PM, Wen Gong wrote:
> On 7/12/2023 10:52 PM, James Prestwood wrote:
>> Hi Wen,
>>
>> On 7/12/23 4:17 AM, Wen Gong wrote:
>>> On 9/4/2021 3:35 AM, James Prestwood wrote:
>>>> ---
>>> ...
>>>> +
>>>> +            case IE_TYPE_RSN:
>>>> +                if (!netdev->owe_sm)
>>>> +                    continue;
>>>> +
>>>> +                if (ie_parse_rsne(&iter, &info) < 0) {
>>>> +                    l_error("could not parse RSN IE");
>>>> +                    goto error;
>>>> +                }
>>>> +
>>>> +                /*
>>>> +                 * RFC 8110 Section 4.2
>>>> +                 * An AP agreeing to do OWE MUST include the OWE 
>>>> AKM in
>>>> +                 * the RSN element portion of the 802.11 association
>>>> +                 * response.
>>>> +                 */
>>> Now it is happen connect to OWE AP fail with some APs, because the 
>>> assoc resp do not inclued RSNE.
>>>> +                if (info.akm_suites != IE_RSN_AKM_SUITE_OWE) {
>>>> +                    l_error("OWE AKM not included");
>>>> +                    goto deauth;
>>>> +                }
>>>> +
>>>> +                owe_akm_found = true;
>>>> +
>>>> +                break;
>>>> +            }
>>>> +        }
>>>> +
>>>> +        if (netdev->owe_sm) {
>>>> +            if (!owe_dh || !owe_akm_found) {
>>>> +                l_error("OWE DH element/RSN not found");
>>>
>>> It failed here.
>>>
>>> So is the check for owe_akm_found MUST added here if owe_dh is 
>>> existed in assoc resp?
>>
>> As the comment states, the OWE RFC says that the RSN element must be 
>> included in the associate response if we are to stay compliant with 
>> the spec.
>>
>> But as you may have noticed we don't actually do anything with this 
>> element besides parse it. I don't see that wpa_supplicant enforces 
>> this either, so it may be fine to relax this check.
> Thanks for you to relax the check.
>>
>> I would prefer to see iwmon logs when you connect to this AP, just to 
>> confirm that the AP isn't including the IE and not something else. 
>> Would you be able to get those?
>>
> I have collected iwd log with hexdump, it does not include RSNIE in 
> assoc resp ies:

Sorry, I should have been more specific. Using IWD_GENL_DEBUG does 
contain the information, but its not really a readable format. We have a 
tool called iwmon which you run in parallel to IWD. This parses the raw 
data and displays a human readable output:

$ sudo iwmon --nortnl --nowiphy --noscan

Denis,

Is relaxing the RSNE check in the associate response (for OWE only) 
something you'd be ok with? Obviously with an L_WARN_ON/l_warn message.

Thanks,
James
