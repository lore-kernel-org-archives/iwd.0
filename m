Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7F28E7
	for <iwd@lists.linux.dev>; Tue, 29 Aug 2023 14:53:16 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so3405941b3a.2
        for <iwd@lists.linux.dev>; Tue, 29 Aug 2023 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693320796; x=1693925596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSFRoccMM8C/sM4+75C7cEjlUQW6ooNJRJPx23uDFfg=;
        b=KIxwmEqCwlTuDRNxmzHn6gyDoS2rD+4sh90h7LitNnSPZ29GQiZ9EuT16DHl7QPGFy
         4+bTMDL3Ev9OBBRAYAMGAYQvGh/Uk0BjAvuLyRHlpCRnmqhAPKu0vyTMsWg1S82slgOn
         Ucs1hNntx9i4QJ1VsJFv7MNE//fupX913xTDtH6+GLGU5gRxcR/n1ZCM5kVAvTcg+Xbx
         w5+W77oYOyrIJnntY77QDvQlkUdDSvl7tNBolWhubBRO4Y+3S2mNb0CDezHFQcNbulRR
         89R9bZ0OMgF4g0HCctAKt6/JziUC64ey6WV+DuC2j0KPTm4ZFuNh02kfpzEXuCvNfU1O
         r+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693320796; x=1693925596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSFRoccMM8C/sM4+75C7cEjlUQW6ooNJRJPx23uDFfg=;
        b=gWWmWv0RPToMUnXi3Aw/p4tBSbGJqxjtPgVOI5uPe7rZw8sgCxrF4JCQMP20/55AiL
         oGmfeg9AmtJ1+wCAMrD6jHwuwuQiUad6Vtn2R2NfBDf8Z2/LRwrjgnHZz/sHE5tknPod
         Yb6lbtvAciYaLIdWT1rrVeRwSNeTsSkJickeRjMW3fD9AQA/sBquaSExta2pB1g+8Nly
         0vypabVywKZY3SpfywR6J7JVhu4JVdNEIJXmkzBl7YZGaw7vDvcGx0HVve/2fagBG/pk
         Vy1zCHJbojYHuvwkakUzECdStP8VUnJ36vLaZfnvT6iEA6tKVlmdwUiC17ILbJutG405
         B0QQ==
X-Gm-Message-State: AOJu0YxEcRONt6Wkrl3JY6tt4u/4SmGNijsPeUMCQyakBtJ7H17reoFO
	iQSw5yk/1Ekjbis89EFGBcAz7a7GgTE=
X-Google-Smtp-Source: AGHT+IFM78Rha+E883sEClLd5Bx4fp7PahDwQaoR9FOrb10twpf4iKOHnLSGxVYrU50BFr5VdoWLOA==
X-Received: by 2002:a05:6a00:148f:b0:68a:4d66:ca1 with SMTP id v15-20020a056a00148f00b0068a4d660ca1mr30340394pfu.6.1693320796058;
        Tue, 29 Aug 2023 07:53:16 -0700 (PDT)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id a3-20020aa78643000000b0068874e1faf2sm8578842pfo.56.2023.08.29.07.53.15
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 07:53:15 -0700 (PDT)
Message-ID: <5f93b857-39d1-45b0-8856-ceca0ccdf18a@gmail.com>
Date: Tue, 29 Aug 2023 07:53:14 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] auto-t: add fallback to reassociate test
To: iwd@lists.linux.dev
References: <20230829145116.279949-1-prestwoj@gmail.com>
 <20230829145116.279949-3-prestwoj@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20230829145116.279949-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Denis,

On 8/29/23 7:51 AM, James Prestwood wrote:
> ---
>   autotests/testPSK-roam/failed_roam_test.py | 90 +++++++++++++++++++++-
>   autotests/testPSK-roam/ft-psk-ccmp-1.conf  |  1 +
>   autotests/testPSK-roam/ft-psk-ccmp-2.conf  |  1 +
>   autotests/testPSK-roam/ft-psk-ccmp-3.conf  |  1 +
>   4 files changed, 90 insertions(+), 3 deletions(-)

I should have sent as a single patchset or made it clear in the notes, 
but this does depend on the 2 prior autotest patches. Sorry about that.

> 
> diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
> index 8a3db662..09947705 100644
> --- a/autotests/testPSK-roam/failed_roam_test.py
> +++ b/autotests/testPSK-roam/failed_roam_test.py
> @@ -41,9 +41,11 @@ class Test(unittest.TestCase):
>           self.assertRaises(Exception, testutil.test_ifaces_connected,
>                             (prev.ifname, device.name, True, True))
>   
> -
>       # FT-over-Air failure, should stay connected
>       def test_ft_over_air_failure(self):
> +        self.rule2.enabled = True
> +        self.rule3.enabled = True
> +
>           wd = IWD(True)
>   
>           device = wd.list_devices(1)[0]
> @@ -60,12 +62,85 @@ class Test(unittest.TestCase):
>           self.rule0.enabled = False
>   
>           # IWD should then try BSS 2, and succeed
> +        device.wait_for_event('ft-roam', timeout=60)
>           self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[2])
>   
>           self.bss_hostapd[2].deauthenticate(device.address)
> +
> +    # FT-over-Air failure with Invalid PMKID, should reassociate
> +    def test_ft_over_air_fallback(self):
> +        self.rule_bss0.signal = -8000
> +        self.rule_bss0.enabled = True
> +        self.rule_bss1.signal = -7500
> +        self.rule_bss1.enabled = True
> +        self.rule_bss2.signal = -6000
> +        self.rule_bss2.enabled = True
> +
> +        # This will cause this BSS to reject any FT roams as its unable to
> +        # get keys from other APs
> +        self.bss_hostapd[2].set_value('ft_psk_generate_local', '0')
> +        self.bss_hostapd[2].reload()
> +
> +        wd = IWD(True)
> +
> +        device = wd.list_devices(1)[0]
> +
> +        self.connect(wd, device, self.bss_hostapd[0])
> +
> +        # IWD should connect, then attempt a roam to BSS 1, which should
> +        # fail and cause a fallback to reassociation
> +        device.wait_for_event('ft-fallback-to-reassoc', timeout=60)
> +        device.wait_for_event('reassoc-roam', timeout=60)
> +
> +        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[2])
> +
> +        # Trigger another roam
> +        self.rule_bss2.signal = -8000
> +
> +        device.wait_for_event('ft-roam', timeout=60)
> +
> +        # Ensure an FT roam back to a properly configured AP works.
> +        self.verify_roam(wd, device, self.bss_hostapd[2], self.bss_hostapd[1])
> +
> +        self.bss_hostapd[1].deauthenticate(device.address)
>           condition = 'obj.state == DeviceState.disconnected'
>           wd.wait_for_object_condition(device, condition)
>   
> +    # FT-over-Air failure with Invalid PMKID. The ranking is such that other
> +    # FT candidates are available so it should FT elsewhere rather than
> +    # retry with reassociation
> +    def test_ft_over_air_fallback_retry_ft(self):
> +        self.rule_bss0.signal = -8000
> +        self.rule_bss0.enabled = True
> +        self.rule_bss1.signal = -7300
> +        self.rule_bss1.enabled = True
> +        self.rule_bss2.signal = -7100
> +        self.rule_bss2.enabled = True
> +
> +        # This will cause this BSS to reject any FT roams as its unable to
> +        # get keys from other APs
> +        self.bss_hostapd[2].set_value('ft_psk_generate_local', '0')
> +        self.bss_hostapd[2].reload()
> +
> +        wd = IWD(True)
> +
> +        device = wd.list_devices(1)[0]
> +
> +        self.connect(wd, device, self.bss_hostapd[0])
> +
> +        # IWD should connect, then attempt a roam to BSS 1, which should
> +        # fail and cause the rank to be re-computed. This shoudl then put
> +        # bss 1 as the next candidate (since the FT factor is removed)
> +        device.wait_for_event('ft-fallback-to-reassoc', timeout=60)
> +        device.wait_for_event('ft-roam', timeout=60)
> +
> +        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[1])
> +
> +        self.bss_hostapd[1].deauthenticate(device.address)
> +        condition = 'obj.state == DeviceState.disconnected'
> +        wd.wait_for_object_condition(device, condition)
> +
> +
>       def tearDown(self):
>           os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
>           os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
> @@ -75,6 +150,10 @@ class Test(unittest.TestCase):
>           self.rule0.enabled = False
>           self.rule1.enabled = False
>           self.rule2.enabled = False
> +        self.rule3.enabled = False
> +        self.rule_bss0.enabled = False
> +        self.rule_bss1.enabled = False
> +        self.rule_bss2.enabled = False
>   
>           for hapd in self.bss_hostapd:
>               hapd.default()
> @@ -109,13 +188,18 @@ class Test(unittest.TestCase):
>           cls.rule2 = hwsim.rules.create()
>           cls.rule2.source = hwsim.get_radio('rad0').addresses[0]
>           cls.rule2.signal = -8000
> -        cls.rule2.enabled = True
>   
>           # Causes IWD to first prefer BSS 1 to roam, then BSS 2.
>           cls.rule3 = hwsim.rules.create()
>           cls.rule3.source = hwsim.get_radio('rad2').addresses[0]
>           cls.rule3.signal = -7000
> -        cls.rule3.enabled = True
> +
> +        cls.rule_bss0 = hwsim.rules.create()
> +        cls.rule_bss0.source = hwsim.get_radio('rad0').addresses[0]
> +        cls.rule_bss1 = hwsim.rules.create()
> +        cls.rule_bss1.source = hwsim.get_radio('rad1').addresses[0]
> +        cls.rule_bss2 = hwsim.rules.create()
> +        cls.rule_bss2.source = hwsim.get_radio('rad2').addresses[0]
>   
>       @classmethod
>       def tearDownClass(cls):
> diff --git a/autotests/testPSK-roam/ft-psk-ccmp-1.conf b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
> index eec8805f..b46d1f27 100644
> --- a/autotests/testPSK-roam/ft-psk-ccmp-1.conf
> +++ b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
> @@ -33,6 +33,7 @@ pmk_r1_push=0
>   # case.  Only works with FT-PSK, otherwise brctl needs to be installed and
>   # CONFIG_BRIDGE enabled in the kernel.
>   ft_psk_generate_local=1
> +rkh_pull_timeout=50
>   ft_over_ds=0
>   ap_table_expiration_time=36000
>   ap_table_max_size=10
> diff --git a/autotests/testPSK-roam/ft-psk-ccmp-2.conf b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
> index 5992461f..3e215457 100644
> --- a/autotests/testPSK-roam/ft-psk-ccmp-2.conf
> +++ b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
> @@ -33,6 +33,7 @@ pmk_r1_push=0
>   # case.  Only works with FT-PSK, otherwise brctl needs to be installed and
>   # CONFIG_BRIDGE enabled in the kernel.
>   ft_psk_generate_local=1
> +rkh_pull_timeout=50
>   ft_over_ds=0
>   ap_table_expiration_time=36000
>   ap_table_max_size=10
> diff --git a/autotests/testPSK-roam/ft-psk-ccmp-3.conf b/autotests/testPSK-roam/ft-psk-ccmp-3.conf
> index 5992461f..3e215457 100644
> --- a/autotests/testPSK-roam/ft-psk-ccmp-3.conf
> +++ b/autotests/testPSK-roam/ft-psk-ccmp-3.conf
> @@ -33,6 +33,7 @@ pmk_r1_push=0
>   # case.  Only works with FT-PSK, otherwise brctl needs to be installed and
>   # CONFIG_BRIDGE enabled in the kernel.
>   ft_psk_generate_local=1
> +rkh_pull_timeout=50
>   ft_over_ds=0
>   ap_table_expiration_time=36000
>   ap_table_max_size=10
