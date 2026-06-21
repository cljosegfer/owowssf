INSERT INTO `spell_cooldown_overrides` (`Id`, `RecoveryTime`, `CategoryRecoveryTime`, `StartRecoveryTime`, `StartRecoveryCategory`, `Comment`) VALUES
(12051, 0, 0, 1500, 133, 'Evocation - remove cooldown'),
(2139,  0, 0, 1500, 133, 'Counterspell - remove cooldown')
ON DUPLICATE KEY UPDATE
    `RecoveryTime`         = VALUES(`RecoveryTime`),
    `CategoryRecoveryTime` = VALUES(`CategoryRecoveryTime`);
