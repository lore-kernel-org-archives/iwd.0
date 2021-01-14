Content-Type: multipart/mixed; boundary="===============7828167895678308235=="
MIME-Version: 1.0
From: georgmueller@gmx.net
Subject: iwd in AP mode: no HT capabilities
Date: Thu, 14 Jan 2021 18:53:58 +0000
Message-ID: <20210114185358.2879.1670@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7828167895678308235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I tried to switch from wpa_supplicant to iwd to start an access point.

When looking at the scan results from another machine, I see that when usin=
g iwd, the device sends no HT capabilities and only supports 11MBit/s.

output from "iw dev wlp2s0 scan":

with iwd based ap:
-----
BSS 74:da:38:f4:e1:42(on wlp2s0)
        last seen: 789976.536s [boottime]
        TSF: 11382336 usec (0d, 00:00:11)
        freq: 2437
        beacon interval: 100 TUs
        capability: ESS Privacy (0x0011)
        signal: -48.00 dBm
        last seen: 4088 ms ago
        Information elements from Probe Response frame:
        SSID: testbox
        Supported rates: 1.0* 5.5 11.0 =

        DS Parameter set: channel 6
        RSN:     * Version: 1
                 * Group cipher: CCMP
                 * Pairwise ciphers: CCMP
                 * Authentication suites: PSK
                 * Capabilities: 1-PTKSA-RC 1-GTKSA-RC (0x0000)
        WPS:     * Version: 1.0
                 * Wi-Fi Protected Setup State: 2 (Configured)
                 * Response Type: 3 (AP)
                 * UUID: 927467be-c802-5217-a136-a5489eb14b24
                 * Manufacturer:  =

                 * Model:  =

                 * Model Number:  =

                 * Serial Number:  =

                 * Primary Device Type: 1-00372a04-1
                 * Device name: testbox
                 * Config methods: PBC
                 * Unknown TLV (0x1049, 6 bytes): 00 37 2a 00 01 20
-----

with wpa_supplicant based ap:
-----
BSS d0:37:45:99:3e:1f(on wlp2s0)
        last seen: 789193.105s [boottime]
        TSF: 5592759 usec (0d, 00:00:05)
        freq: 2412
        beacon interval: 100 TUs
        capability: ESS Privacy ShortSlotTime (0x0411)
        signal: -58.00 dBm
        last seen: 3230 ms ago
        Information elements from Probe Response frame:
        SSID: testbox
        Supported rates: 1.0* 2.0* 5.5* 11.0* 6.0 9.0 12.0 18.0 =

        DS Parameter set: channel 1
        ERP: Barker_Preamble_Mode
        Extended supported rates: 24.0 36.0 48.0 54.0 =

        RSN:     * Version: 1
                 * Group cipher: CCMP
                 * Pairwise ciphers: CCMP
                 * Authentication suites: PSK PSK/SHA-256
                 * Capabilities: 16-PTKSA-RC 1-GTKSA-RC (0x000c)
        HT capabilities:
                Capabilities: 0x92c
                        HT20
                        SM Power Save disabled
                        RX HT20 SGI
                        RX STBC 1-stream
                        Max AMSDU length: 7935 bytes
                        No DSSS/CCK HT40
                Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
                Minimum RX AMPDU time spacing: 16 usec (0x07)
                HT Max RX data rate: 476 Mbps
                HT TX/RX MCS rate indexes supported: 0-7
        HT operation:
                 * primary channel: 1
                 * secondary channel offset: no secondary
                 * STA channel width: 20 MHz
                 * RIFS: 0
                 * HT protection: no
                 * non-GF present: 0
                 * OBSS non-GF present: 0
                 * dual beacon: 0
                 * dual CTS protection: 0
                 * STBC beacon: 0
                 * L-SIG TXOP Prot: 0
                 * PCO active: 0
                 * PCO phase: 0
        WMM:     * Parameter version 1
                 * u-APSD
                 * BE: CW 15-1023, AIFSN 3
                 * BK: CW 15-1023, AIFSN 7
                 * VI: CW 7-15, AIFSN 2, TXOP 2976 usec
                 * VO: CW 3-7, AIFSN 2, TXOP 1472 usec
        WPS:     * Version: 1.0
                 * Wi-Fi Protected Setup State: 2 (Configured)
                 * Unknown TLV (0x1049, 6 bytes): 00 37 2a 00 01 20
                 * Device name:  =

                 * Primary Device Type: 0-00000000-0
-----

Is this a driver issue or a general problem with iwd?

Best regards,
Georg
--===============7828167895678308235==--

